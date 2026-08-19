#!/usr/bin/env python3
"""Static invariants for infra-pkg package recipes (single-tree layout).

Every top-level directory holding a Makefile is a package recipe. Most recipes
produce the same-named package; the two Victoria recipes intentionally build a
small, version-locked package group. Arch-parameterized packages build via
`make one ARCH=<amd64|arm64>` with manifests using `arch: "${ARCH}"`;
noarch-style packages build once with `arch: "all"`. Packages with genuinely
different per-arch metadata split into `<base>.amd64.yaml` +
`<base>.arm64.yaml`. Vendor-direct recipes are an explicit exception: they
download checksum-pinned native DEB/RPM artifacts and never run nFPM.
"""

from __future__ import annotations

import re
import sys
from collections import defaultdict
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional, Tuple

try:
    import yaml
except ImportError:
    print("PyYAML is required to lint package manifests", file=sys.stderr)
    raise SystemExit(2)


ROOT = Path(__file__).resolve().parents[1]
ARCHS = ("amd64", "arm64")
PACKAGE_RELEASE = "1PGSTY"
PACKAGE_VENDOR = "PGSTY"
PACKAGE_MAINTAINER = "Ruohang Feng <rh@vonng.com>"
DEBIAN_PRIORITY = "optional"
DEBIAN_CHANGELOG = "${NFPM_CHANGELOG}"
DEBIAN_SECTIONS = {"admin", "database", "devel", "net", "utils", "web"}
# Victoria upstream publishes several same-version artifacts in one release;
# keeping each family in one recipe avoids duplicating downloads and checksums.
PACKAGE_GROUPS = {
    "victoria-logs": {"victoria-logs", "vlagent", "vlogscli"},
    "victoria-metrics": {"victoria-metrics", "victoria-metrics-cluster", "vmutils"},
}
PACKAGE_DIR_RE = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")
PACKAGE_NAME_RE = re.compile(r"^[a-z0-9]+(?:[+.-][a-z0-9]+)*$")
PRERELEASE_RE = re.compile(r"^(?:alpha|beta|rc)[1-9][0-9]*$")
PACKAGE_FORMATS = {"deb", "rpm"}
FORBIDDEN_RELATION_FIELDS = {"conflicts", "obsoletes", "provides", "replaces"}
FORBIDDEN_TRANSACTION_PHASES = {"posttrans", "pretrans"}
# SPDX identifiers currently used by this repository. Keeping this list
# explicit rejects ambiguous Fedora/Debian aliases such as "ASL 2.0" or
# "GPLv2+" while making additions deliberate and reviewable.
SPDX_LICENSE_IDS = {
    "AGPL-3.0-only",
    "AGPL-3.0-or-later",
    "Apache-2.0",
    "BSD-2-Clause",
    "BSD-3-Clause",
    "FSL-1.1-MIT",
    "GPL-2.0-only",
    "GPL-2.0-or-later",
    "GPL-3.0-only",
    "GPL-3.0-or-later",
    "LGPL-2.1-or-later",
    "MIT",
    "MPL-2.0",
    "PostgreSQL",
}
SPDX_TOKEN_RE = re.compile(
    r"LicenseRef-[A-Za-z0-9.-]+|[A-Za-z0-9][A-Za-z0-9.-]*|AND|OR|WITH|[()]"
)
SYSTEMD_FORBIDDEN_DIRECTIVES = {
    "AmbientCapabilities",
    "ProtectClock",
    "ProtectControlGroups",
    "ProtectKernelModules",
    "ProtectKernelTunables",
    "RestrictRealtime",
    "RestrictSUIDSGID",
    "TasksMax",
}
SYSTEMD_FILE_OUTPUT_RE = re.compile(
    r"^\s*Standard(?:Output|Error)\s*=\s*(?:append|file|truncate):", re.M
)
LICENSE_BASENAME_RE = re.compile(
    r"^(?:licen[cs]e|copying|copyright|third-party-licenses)(?:[._-].*)?$",
    re.IGNORECASE,
)
OVERRIDE_LIST_FIELDS = {
    "conflicts",
    "depends",
    "provides",
    "recommends",
    "replaces",
    "suggests",
}

SPLIT_RE = re.compile(r"^(?P<base>.+)\.(?P<arch>amd64|arm64)\.ya?ml$")
VENDOR_DIRECT_INCLUDE = "include ../mk/vendor-direct.mk"


def package_dirs() -> List[Path]:
    return sorted(p.parent for p in ROOT.glob("*/Makefile"))


def package_manifests() -> Iterable[Path]:
    for pkg in package_dirs():
        yield from sorted(pkg.glob("*.yaml"))


def allowed_package_names(directory: str) -> set[str]:
    return PACKAGE_GROUPS.get(directory, {directory})


def is_vendor_direct(text: str) -> bool:
    return bool(re.search(r"^VENDOR_DIRECT\s*=\s*1\s*$", text, re.M))


def valid_spdx_expression(value: str) -> bool:
    tokens = SPDX_TOKEN_RE.findall(value)
    if not tokens or "".join(tokens) != re.sub(r"\s+", "", value):
        return False
    atoms = {
        token for token in tokens
        if token not in {"AND", "OR", "WITH", "(", ")"}
    }
    return all(
        atom in SPDX_LICENSE_IDS or atom.startswith("LicenseRef-")
        for atom in atoms
    )


def parse_mode(value: Any) -> Optional[int]:
    if isinstance(value, int):
        return value
    if isinstance(value, str):
        try:
            return int(value, 8)
        except ValueError:
            return None
    return None


def file_info(entry: Dict[str, Any]) -> Tuple[Optional[str], Optional[str], Optional[int]]:
    info = entry.get("file_info") or {}
    return info.get("owner"), info.get("group"), parse_mode(info.get("mode"))


def is_arch_parameterized(makefile_text: str) -> bool:
    return bool(re.search(r"^ARCH\s*\?=", makefile_text, re.M))


def lint_manifest(path: Path, data: Dict[str, Any], errors: List[str],
                  arch_pkg: bool) -> Tuple[str, str, str]:
    rel = path.relative_to(ROOT)
    name = str(data.get("name", ""))
    version = str(data.get("version", ""))
    prerelease = str(data.get("prerelease", "")).strip()
    release = data.get("release")
    license_id = str(data.get("license", "")).strip()
    vendor = str(data.get("vendor", "")).strip()
    maintainer = str(data.get("maintainer", "")).strip()
    section = str(data.get("section", "")).strip()
    priority = str(data.get("priority", "")).strip()
    changelog = str(data.get("changelog", "")).strip()

    if not PACKAGE_NAME_RE.fullmatch(name):
        errors.append(f"{rel}: package name must use lowercase SPDX/Debian-safe syntax: {name!r}")
    expected_names = allowed_package_names(path.parent.name)
    if name not in expected_names:
        errors.append(
            f"{rel}: package name {name!r} must match its recipe; expected one of "
            + ", ".join(sorted(expected_names))
        )
    if vendor != PACKAGE_VENDOR:
        errors.append(f"{rel}: vendor must be {PACKAGE_VENDOR!r} (found {vendor or 'missing'!r})")
    if maintainer != PACKAGE_MAINTAINER:
        errors.append(
            f"{rel}: maintainer must be {PACKAGE_MAINTAINER!r} "
            f"(found {maintainer or 'missing'!r})"
        )
    if section not in DEBIAN_SECTIONS:
        errors.append(
            f"{rel}: section must be one of {', '.join(sorted(DEBIAN_SECTIONS))} "
            f"(found {section or 'missing'!r})"
        )
    if priority != DEBIAN_PRIORITY:
        errors.append(
            f"{rel}: priority must be {DEBIAN_PRIORITY!r} "
            f"(found {priority or 'missing'!r})"
        )
    if changelog != DEBIAN_CHANGELOG:
        errors.append(
            f"{rel}: changelog must be generated through {DEBIAN_CHANGELOG!r} "
            f"(found {changelog or 'missing'!r})"
        )
    if not valid_spdx_expression(license_id):
        errors.append(f"{rel}: license must be a recognized SPDX expression (found {license_id or 'missing'!r})")
    if prerelease and not PRERELEASE_RE.fullmatch(prerelease):
        errors.append(
            f"{rel}: prerelease must use alphaN, betaN, or rcN syntax (found {prerelease!r})"
        )
    release_text = "" if release is None else str(release).strip()
    if release_text != PACKAGE_RELEASE:
        errors.append(
            f"{rel}: release must be {PACKAGE_RELEASE} (found {release_text or 'missing'})"
        )

    arch = str(data.get("arch", ""))
    split = SPLIT_RE.match(path.name)
    if split:
        if arch != split.group("arch"):
            errors.append(f"{rel}: split manifest must declare arch: {split.group('arch')}")
    elif arch_pkg:
        if arch != "${ARCH}":
            errors.append(f'{rel}: arch must be "${{ARCH}}" (found {arch!r})')
    else:
        if arch != "all":
            errors.append(f'{rel}: noarch-style manifest must use arch: all (found {arch!r})')

    for field in sorted(FORBIDDEN_RELATION_FIELDS & set(data)):
        errors.append(
            f"{rel}: package compatibility field {field} is forbidden; "
            "do not encode migration policy in current packages"
        )

    overrides = data.get("overrides") or {}
    if not isinstance(overrides, dict):
        errors.append(f"{rel}: overrides must be a mapping")
    else:
        for packager, override in overrides.items():
            if packager not in PACKAGE_FORMATS:
                errors.append(f"{rel}: unsupported package override: {packager}")
            if not isinstance(override, dict):
                errors.append(f"{rel}: overrides.{packager} must be a mapping")
                continue
            unsupported = sorted(set(override) - OVERRIDE_LIST_FIELDS)
            if unsupported:
                errors.append(
                    f"{rel}: overrides.{packager} has unsupported fields: {', '.join(unsupported)}"
                )
            for field in sorted(set(override) & OVERRIDE_LIST_FIELDS):
                values = override[field]
                if not isinstance(values, list) or not all(isinstance(value, str) for value in values):
                    errors.append(f"{rel}: overrides.{packager}.{field} must be a string list")
            for field in sorted(FORBIDDEN_RELATION_FIELDS & set(override)):
                errors.append(
                    f"{rel}: overrides.{packager}.{field} is forbidden; "
                    "do not encode migration policy in current packages"
                )

    scripts = data.get("scripts") or {}
    if not isinstance(scripts, dict):
        errors.append(f"{rel}: scripts must be a mapping")
        scripts = {}
    else:
        for phase, source in scripts.items():
            if phase in FORBIDDEN_TRANSACTION_PHASES:
                errors.append(f"{rel}: transaction script {phase} is forbidden")
            script_path = path.parent / str(source)
            if not script_path.is_file():
                errors.append(f"{rel}: {phase} script does not exist: {source}")

    rpm = data.get("rpm") or {}
    rpm_scripts = rpm.get("scripts") or {} if isinstance(rpm, dict) else {}
    if not isinstance(rpm_scripts, dict):
        errors.append(f"{rel}: rpm.scripts must be a mapping")
    else:
        for phase, source in rpm_scripts.items():
            if phase in FORBIDDEN_TRANSACTION_PHASES:
                errors.append(f"{rel}: rpm transaction script {phase} is forbidden")
            script_path = path.parent / str(source)
            if not script_path.is_file():
                errors.append(f"{rel}: rpm.{phase} script does not exist: {source}")

    destinations = set()
    units: List[str] = []
    uses_arch_var = False
    has_license_payload = False
    has_debian_copyright = False
    contents = data.get("contents") or []
    if not isinstance(contents, list):
        errors.append(f"{rel}: contents must be a list")
        contents = []
    for entry in contents:
        if not isinstance(entry, dict):
            errors.append(f"{rel}: content entry must be a mapping")
            continue
        source = str(entry.get("src", ""))
        destination = str(entry.get("dst", ""))
        is_license_entry = source != "${NFPM_COPYRIGHT}" and any(
            LICENSE_BASENAME_RE.fullmatch(Path(value.rstrip("/")).name)
            for value in (source, destination)
        )
        is_notice_entry = any(
            Path(value.rstrip("/")).name.upper().startswith("NOTICE")
            for value in (source, destination)
        )
        if is_license_entry:
            has_license_payload = True
        if source.startswith("../LICENSES/") and not (path.parent / source).is_file():
            errors.append(f"{rel}: shared license does not exist: {source}")
        if "${ARCH}" in source or "${RARCH}" in source \
                or "${ARCH}" in destination or "${RARCH}" in destination:
            uses_arch_var = True
        if not destination:
            errors.append(f"{rel}: content entry has no destination")
            continue
        if destination in destinations:
            errors.append(f"{rel}: duplicate destination {destination}")
        destinations.add(destination)
        if destination.startswith("/usr/local/"):
            errors.append(f"{rel}: package payload must not use /usr/local: {destination}")
        if destination.startswith("/data/"):
            errors.append(f"{rel}: persistent package state must use /var/lib, not /data: {destination}")
        if destination.startswith("/var/logs/"):
            errors.append(f"{rel}: log paths must use /var/log, not /var/logs: {destination}")
        if is_license_entry or is_notice_entry:
            doc_prefix = f"/usr/share/doc/{name}/"
            if not destination.startswith(doc_prefix):
                errors.append(
                    f"{rel}: LICENSE/NOTICE payload must use {doc_prefix}: {destination}"
                )

        owner, group, mode = file_info(entry)
        entry_type = entry.get("type")
        copyright_destination = f"/usr/share/doc/{name}/copyright"
        if destination == copyright_destination:
            has_debian_copyright = True
            if source != "${NFPM_COPYRIGHT}":
                errors.append(
                    f"{rel}: Debian copyright must be rendered from packaged legal documents"
                )
            if entry.get("packager") != "deb":
                errors.append(f"{rel}: Debian copyright entry must use packager: deb")
            if (owner, group, mode) != ("root", "root", 0o644):
                errors.append(f"{rel}: Debian copyright must be root:root 0644")
        if destination.endswith(".service") and "/systemd/system/" in destination:
            units.append(Path(destination).name)
            expected = f"/usr/lib/systemd/system/{Path(destination).name}"
            if destination != expected:
                errors.append(f"{rel}: vendor unit must use {expected}, found {destination}")
            if entry_type not in (None, "file"):
                errors.append(f"{rel}: systemd unit must be an ordinary file: {destination}")
            if (owner, group, mode) != ("root", "root", 0o644):
                errors.append(f"{rel}: systemd unit must be root:root 0644: {destination}")
            unit_path = path.parent / source
            if unit_path.is_file():
                unit_text = unit_path.read_text(encoding="utf-8")
                if "/etc/sysconfig/" in unit_text:
                    errors.append(
                        f"{rel}: systemd unit must use /etc/default, not /etc/sysconfig: {source}"
                    )
                for directive in sorted(SYSTEMD_FORBIDDEN_DIRECTIVES):
                    if re.search(rf"^\s*{re.escape(directive)}\s*=", unit_text, re.M):
                        errors.append(
                            f"{rel}: systemd unit uses nonessential compatibility-sensitive "
                            f"directive {directive}: {source}"
                        )
                if SYSTEMD_FILE_OUTPUT_RE.search(unit_text):
                    errors.append(
                        f"{rel}: systemd unit must log to the journal instead of a file output directive: {source}"
                    )

        if destination.startswith("/etc/default/"):
            if owner != "root":
                errors.append(f"{rel}: /etc/default file must be owned by root: {destination}")
            if mode is None or mode & 0o111:
                errors.append(f"{rel}: /etc/default file must not be executable: {destination}")
            if destination.endswith((".yaml", ".yml")):
                errors.append(
                    f"{rel}: structured configuration belongs under /etc/{name}, not /etc/default: "
                    f"{destination}"
                )

        if (
            destination.startswith(("/usr/bin/", "/usr/sbin/", "/usr/libexec/"))
            and entry_type not in ("dir", "symlink")
            and mode != 0o755
        ):
            errors.append(f"{rel}: executable payload must declare mode 0755: {destination}")

    if (arch == "${ARCH}" or uses_arch_var):
        makefile = (path.parent / "Makefile").read_text(encoding="utf-8")
        if not re.search(r"^export ARCH RARCH\s*$", makefile, re.M):
            errors.append(f"{rel}: manifest uses ${{ARCH}}/${{RARCH}} but Makefile lacks `export ARCH RARCH`")

    if units:
        required_phases = {"postinstall", "preremove", "postremove"}
        missing_phases = sorted(required_phases - set(scripts))
        if missing_phases:
            errors.append(f"{rel}: unit package missing lifecycle scripts: {', '.join(missing_phases)}")
        script_text: Dict[str, str] = {}
        for phase, source in scripts.items():
            source_path = path.parent / str(source)
            if source_path.is_file():
                script_text[phase] = source_path.read_text(encoding="utf-8")
        for phase in ("postinstall", "postremove"):
            if phase in script_text and "systemctl daemon-reload" not in script_text[phase]:
                errors.append(f"{rel}: {phase} must run systemctl daemon-reload")
        for unit in units:
            if unit not in script_text.get("preremove", ""):
                errors.append(f"{rel}: preremove does not manage {unit}")

    if not has_license_payload:
        errors.append(f"{rel}: package payload has no LICENSE/COPYING file")
    if not has_debian_copyright:
        errors.append(f"{rel}: DEB payload has no /usr/share/doc/{name}/copyright file")

    return name, version, "" if release is None else str(release)


def lint_split_manifests(errors: List[str]) -> None:
    """<base>.amd64.yaml and <base>.arm64.yaml must come in pairs."""
    for pkg in package_dirs():
        bases: Dict[str, set] = defaultdict(set)
        for path in pkg.glob("*.yaml"):
            match = SPLIT_RE.match(path.name)
            if match:
                bases[match.group("base")].add(match.group("arch"))
        for base, archs in sorted(bases.items()):
            missing = set(ARCHS) - archs
            if missing:
                errors.append(
                    f"{pkg.relative_to(ROOT)}: split manifest {base} missing arch variants: "
                    + ", ".join(sorted(missing))
                )


def lint_shell(errors: List[str]) -> None:
    for pkg in package_dirs():
        for path in sorted(pkg.glob("**/*.sh")):
            text = path.read_text(encoding="utf-8")
            if not text.startswith("#!/bin/sh"):
                continue
            if "/usr/local/" in text:
                errors.append(
                    f"{path.relative_to(ROOT)}: package scripts must not manage /usr/local"
                )
            if "dpkg-maintscript-helper" in text or "rm_conffile" in text:
                errors.append(
                    f"{path.relative_to(ROOT)}: legacy conffile migration is forbidden"
                )
            if path.name.endswith("postinstall.sh") and re.search(
                r"^\s*(?:chown|chmod)\b", text, re.M
            ):
                errors.append(
                    f"{path.relative_to(ROOT)}: postinstall must not rewrite packaged "
                    "metadata; use nFPM file_info"
                )
            if path.name.endswith("postinstall.sh") and "systemctl --no-reload preset" in text:
                if 'case "${1:-}:${2:-}" in' not in text or "1:*|configure:)" not in text:
                    errors.append(
                        f"{path.relative_to(ROOT)}: service preset must handle RPM initial install "
                        "and Debian postinst configure, but not upgrades"
                    )
            if path.name.endswith("preremove.sh") and "k3s-killall.sh" in text:
                errors.append(
                    f"{path.relative_to(ROOT)}: package removal must not run the destructive "
                    "k3s-killall helper"
                )
            for pattern, label in (
                (r"&>", "bash-only &> redirection"),
                (r"\[\[(?!:)", "bash-only [[ test"),
            ):
                if re.search(pattern, text):
                    errors.append(f"{path.relative_to(ROOT)}: {label} under /bin/sh")


def lint_runtime_paths(errors: List[str]) -> None:
    forbidden = {
        "/data/rustfs": "RustFS state belongs under /var/lib/rustfs",
        "/var/logs/": "log paths use /var/log, never /var/logs",
        "/tmp/alertmanager": "Alertmanager state must be persistent under /var/lib",
        "/tmp/pushgateway": "Pushgateway state must be persistent under /var/lib",
        "/var/log/positions.yaml": "Promtail positions are state and belong under /var/lib",
        "/etc/default/vip-manager.yml": "vip-manager YAML belongs under /etc/vip-manager",
    }
    for pkg in package_dirs():
        source_dir = pkg / "src"
        if not source_dir.is_dir():
            continue
        for path in sorted(item for item in source_dir.rglob("*") if item.is_file()):
            text = path.read_text(encoding="utf-8", errors="replace")
            for value, explanation in forbidden.items():
                if value in text:
                    errors.append(f"{path.relative_to(ROOT)}: {explanation} (found {value})")


def make_variable(text: str, name: str) -> Optional[str]:
    match = re.search(
        rf"^{re.escape(name)}\s*[:?]?=\s*(?:\"([^\"]*)\"|'([^']*)'|([^\s#]+))",
        text,
        re.M,
    )
    if not match:
        return None
    return next(value for value in match.groups() if value is not None)


def comparable_version(package: str, version: str) -> str:
    if re.match(r"^[vV]\d", version):
        version = version[1:]
    if package == "rustfs":
        version = re.sub(r"-(?:alpha|beta|rc)\.\d+(?:-preview\.\d+)?$", "", version)
    return version


def resolve_config_names(config: str, text: str) -> List[str]:
    """Resolve --config argument to concrete filenames (handles $(NFPM_CONFIG))."""
    if "$(" not in config:
        return [config]
    match = re.match(r"\$\(([A-Za-z_][A-Za-z0-9_]*)\)$", config)
    if not match:
        return []
    value = make_variable(text, match.group(1))
    if value is None:
        return []
    if "$(ARCH)" in value:
        return [value.replace("$(ARCH)", arch) for arch in ARCHS]
    return [value]


def lint_package_layout(errors: List[str]) -> None:
    for pkg in package_dirs():
        rel = pkg.relative_to(ROOT)
        makefile_text = (pkg / "Makefile").read_text(encoding="utf-8")
        if not PACKAGE_DIR_RE.fullmatch(pkg.name):
            errors.append(
                f"{rel}: package recipe directory must use lowercase hyphen-separated names"
            )

        manifests = sorted(pkg.glob("*.yaml"))
        if is_vendor_direct(makefile_text):
            if manifests:
                errors.append(
                    f"{rel}: vendor-direct recipe must not contain nFPM manifests"
                )
            package = make_variable(makefile_text, "PACKAGE")
            expected = allowed_package_names(pkg.name)
            if package not in expected:
                errors.append(
                    f"{rel}: vendor-direct PACKAGE must match its recipe; expected one of "
                    + ", ".join(sorted(expected))
                )
            continue

        names = set()
        for manifest in manifests:
            try:
                data = yaml.safe_load(manifest.read_text(encoding="utf-8"))
            except Exception:
                continue
            if isinstance(data, dict) and {"name", "version", "contents"}.issubset(data):
                names.add(str(data["name"]))
        expected = allowed_package_names(pkg.name)
        if names != expected:
            missing = sorted(expected - names)
            unexpected = sorted(names - expected)
            details = []
            if missing:
                details.append("missing " + ", ".join(missing))
            if unexpected:
                details.append("unexpected " + ", ".join(unexpected))
            errors.append(f"{rel}: recipe artifact set mismatch ({'; '.join(details)})")


def lint_vendor_direct_makefile(
    pkg: Path, text: str, errors: List[str]
) -> None:
    rel = (pkg / "Makefile").relative_to(ROOT)
    if VENDOR_DIRECT_INCLUDE not in text.splitlines():
        errors.append(f"{rel}: vendor-direct recipe must include ../mk/vendor-direct.mk")
    if not re.search(r"^one:\s+download\s+verify\s+build\s+clean\s*$", text, re.M):
        errors.append(f"{rel}: vendor-direct one target must download, verify, build, then clean")
    if make_variable(text, "PROXY") != "http://127.0.0.1:8118":
        errors.append(f"{rel}: vendor-direct downloads must default to proxy port 8118")
    if not make_variable(text, "VERSION"):
        errors.append(f"{rel}: vendor-direct recipe must declare VERSION")

    for arch in ARCHS:
        for packager, suffix in (("DEB", ".deb"), ("RPM", ".rpm")):
            filename_var = f"{packager}_FILE_{arch}"
            url_var = f"{packager}_URL_{arch}"
            checksum_var = f"SHA256_{packager}_{arch}"
            filename = make_variable(text, filename_var)
            url = make_variable(text, url_var)
            checksum = make_variable(text, checksum_var)
            if not filename or not filename.endswith(suffix):
                errors.append(f"{rel}: {filename_var} must name a {suffix} artifact")
            if not url or not url.startswith("https://"):
                errors.append(f"{rel}: {url_var} must use HTTPS")
            if not checksum or not re.fullmatch(r"[0-9a-f]{64}", checksum):
                errors.append(f"{rel}: {checksum_var} must be a pinned lowercase SHA256")


def lint_vendor_direct_shared(errors: List[str]) -> None:
    path = ROOT / "mk/vendor-direct.mk"
    if not path.is_file():
        errors.append("mk/vendor-direct.mk: missing shared vendor-direct implementation")
        return
    text = path.read_text(encoding="utf-8")
    required = {
        "curl failure handling": r"curl\s+--fail\b",
        "proxy use": r"--proxy\s+\$\(PROXY\)",
        "checksum verification": r"(?:sha256sum|shasum\s+-a\s+256).*?-c",
        "DEB output": r"\.\./dist/deb/",
        "RPM output": r"\.\./dist/rpm/",
        "cleanup": r"^clean:\s*$",
    }
    for label, pattern in required.items():
        if not re.search(pattern, text, re.M | re.S):
            errors.append(f"mk/vendor-direct.mk: missing {label}")


def lint_makefiles(errors: List[str]) -> None:
    for pkg in package_dirs():
        path = pkg / "Makefile"
        text = path.read_text(encoding="utf-8")
        rel = path.relative_to(ROOT)
        arch_pkg = is_arch_parameterized(text)
        configs: Dict[str, set] = {"rpm": set(), "deb": set()}
        if not re.search(r"^\.NOTPARALLEL:\s*$", text, re.M):
            errors.append(f"{rel}: missing .NOTPARALLEL build-race guard")
        if arch_pkg:
            if not re.search(r"^ARCH\s*\?=", text, re.M) or not re.search(r"^ARCHS\s*\?=", text, re.M):
                errors.append(f"{rel}: arch-parameterized Makefile must declare ARCH ?= and ARCHS ?=")
        if re.search(r"^download:\s*$", text, re.M):
            if not re.search(r"^SHA(?:256|512)[A-Za-z0-9_]*\s*=", text, re.M):
                errors.append(f"{rel}: downloaded inputs must declare a pinned SHA256/SHA512 checksum")
            if not re.search(
                r"(?:sha256sum|sha512sum|shasum\s+-a\s+(?:256|512)).*?-c",
                text,
                re.S,
            ):
                errors.append(f"{rel}: downloaded inputs must be checksum-verified before packaging")
        for number, line in enumerate(text.splitlines(), 1):
            if "nfpm package" in line and not line.strip().startswith("../bin/nfpm package"):
                errors.append(f"{rel}:{number}: bypasses pinned nFPM wrapper")
            if "nfpm package" in line:
                config_match = re.search(r"--config\s+(\S+)", line)
                packager_match = re.search(r"--packager\s+(rpm|deb)", line)
                if not config_match or not packager_match:
                    errors.append(f"{rel}:{number}: incomplete nFPM command")
                else:
                    config = config_match.group(1)
                    packager = packager_match.group(1)
                    configs[packager].add(config)
                    resolved = resolve_config_names(config, text)
                    if not resolved:
                        errors.append(f"{rel}:{number}: cannot resolve nFPM config {config}")
                    for concrete in resolved:
                        if not (pkg / concrete).is_file():
                            errors.append(f"{rel}:{number}: missing nFPM config {concrete}")
                target_match = re.search(r"--target\s+(\S+)", line)
                if target_match and packager_match:
                    expected = f"../dist/{packager_match.group(1)}/"
                    if target_match.group(1) != expected:
                        errors.append(f"{rel}:{number}: build target must be {expected}")
            if "curl" in line and not line.lstrip().startswith(("#", "@echo")):
                curl_args = line.split("curl", 1)[1]
                has_fail = "--fail" in curl_args or re.search(r"(?:^|\s)-[A-Za-z]*f[A-Za-z]*", curl_args)
                if not has_fail:
                    errors.append(f"{rel}:{number}: curl download must fail on HTTP errors")

        if configs["rpm"] != configs["deb"]:
            errors.append(f"{rel}: RPM and DEB builds must use the same nFPM configs")

        if is_vendor_direct(text):
            lint_vendor_direct_makefile(pkg, text, errors)
            continue

        package = make_variable(text, "PACKAGE")
        version = make_variable(text, "VERSION")
        release = make_variable(text, "RELEASE")
        if not package:
            continue
        expected_names = allowed_package_names(pkg.name)
        for manifest in sorted(pkg.glob("*.yaml")):
            try:
                data = yaml.safe_load(manifest.read_text(encoding="utf-8"))
            except Exception:
                continue
            if not isinstance(data, dict) or not {"name", "version", "contents"}.issubset(data):
                continue
            manifest_name = str(data["name"])
            if manifest_name not in expected_names:
                continue
            mrel = manifest.relative_to(ROOT)
            manifest_version = str(data["version"])
            if version and comparable_version(pkg.name, version) != comparable_version(pkg.name, manifest_version):
                errors.append(
                    f"{mrel}: version {manifest_version} differs from Makefile VERSION={version}"
                )
            manifest_release = str(data.get("release", ""))
            if release and release != manifest_release:
                errors.append(
                    f"{mrel}: release {manifest_release} differs from Makefile RELEASE={release}"
                )


def package_build_version(data: Dict[str, Any]) -> str:
    version = str(data.get("version", ""))
    if re.match(r"^[vV]\d", version):
        version = version[1:]
    prerelease = str(data.get("prerelease", "")).strip()
    if prerelease:
        version += f"-{prerelease}"
    return f"{version}-{data.get('release', '')}"


def exact_dependency(dependency: str, packager: str) -> Optional[Tuple[str, str]]:
    if packager == "deb":
        match = re.fullmatch(
            r"\s*([a-z0-9][a-z0-9+.-]*)\s*\(=\s*([^()\s]+)\s*\)\s*",
            dependency,
        )
    else:
        match = re.fullmatch(
            r"\s*([a-z0-9][a-z0-9+.-]*)\s*=\s*([^\s]+)\s*",
            dependency,
        )
    if not match:
        return None
    return match.group(1), match.group(2)


def lint_internal_dependencies(
    manifests: List[Tuple[Path, Dict[str, Any]]], errors: List[str]
) -> None:
    local: Dict[str, Tuple[Path, Dict[str, Any]]] = {}
    for path, data in manifests:
        local.setdefault(str(data["name"]), (path, data))

    for path, data in manifests:
        overrides = data.get("overrides") or {}
        if not isinstance(overrides, dict):
            continue
        for packager in PACKAGE_FORMATS:
            override = overrides.get(packager) or {}
            if not isinstance(override, dict):
                continue
            dependencies = override.get("depends") or []
            if not isinstance(dependencies, list):
                continue
            for dependency in dependencies:
                if not isinstance(dependency, str):
                    continue
                parsed = exact_dependency(dependency, packager)
                if not parsed:
                    continue
                dependency_name, pinned_version = parsed
                if dependency_name not in local:
                    continue
                _, dependency_data = local[dependency_name]
                expected = package_build_version(dependency_data)
                if pinned_version != expected:
                    errors.append(
                        f"{path.relative_to(ROOT)}: {packager} dependency {dependency_name} "
                        f"pins {pinned_version}, expected {expected}"
                    )


def main() -> int:
    errors: List[str] = []
    versions: Dict[str, set] = defaultdict(set)
    artifacts: Dict[Tuple[Path, str], List[Path]] = defaultdict(list)
    manifests: List[Tuple[Path, Dict[str, Any]]] = []
    count = 0
    for path in package_manifests():
        try:
            data = yaml.safe_load(path.read_text(encoding="utf-8"))
        except Exception as exc:
            errors.append(f"{path.relative_to(ROOT)}: invalid YAML: {exc}")
            continue
        if not isinstance(data, dict) or not {"name", "version", "contents"}.issubset(data):
            continue
        count += 1
        manifests.append((path, data))
        makefile_text = (path.parent / "Makefile").read_text(encoding="utf-8")
        arch_pkg = is_arch_parameterized(makefile_text)
        name, version, release = lint_manifest(path, data, errors, arch_pkg)
        versions[name].add((version, str(data.get("prerelease", "")), release))
        # split per-arch manifests describe one logical artifact
        split = SPLIT_RE.match(path.name)
        key_name = f"{split.group('base')}:{name}" if split else path.name + ":" + name
        artifacts[(path.parent, key_name)].append(path)
        if path.name.endswith(("-deb.yaml", "-rpm.yaml")):
            errors.append(
                f"{path.relative_to(ROOT)}: split RPM/DEB manifests are forbidden; use one config with overrides"
            )

    for (directory, key), paths in sorted(artifacts.items()):
        split_variants = [p for p in paths if SPLIT_RE.match(p.name)]
        if split_variants and len(paths) > len(ARCHS):
            rendered = ", ".join(path.name for path in paths)
            errors.append(
                f"{directory.relative_to(ROOT)}/{key}: too many manifests for one artifact: {rendered}"
            )
        if not split_variants and len(paths) > 1:
            rendered = ", ".join(path.name for path in paths)
            errors.append(
                f"{directory.relative_to(ROOT)}/{key}: one artifact has multiple nFPM manifests: {rendered}"
            )

    for name, values in sorted(versions.items()):
        if len(values) != 1:
            rendered = ", ".join(
                f"{version}{('-' + prerelease) if prerelease else ''}-{release}"
                for version, prerelease, release in sorted(values)
            )
            errors.append(f"{name}: inconsistent manifest versions: {rendered}")

    lint_package_layout(errors)
    lint_vendor_direct_shared(errors)
    lint_split_manifests(errors)
    lint_shell(errors)
    lint_runtime_paths(errors)
    lint_makefiles(errors)
    lint_internal_dependencies(manifests, errors)

    if errors:
        for error in errors:
            print(f"ERROR: {error}", file=sys.stderr)
        print(f"lint failed with {len(errors)} error(s)", file=sys.stderr)
        return 1
    direct_count = sum(
        is_vendor_direct((pkg / "Makefile").read_text(encoding="utf-8"))
        for pkg in package_dirs()
    )
    print(
        f"lint passed: {count} nFPM manifests and {direct_count} vendor-direct "
        f"recipes across {len(package_dirs())} packages"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
