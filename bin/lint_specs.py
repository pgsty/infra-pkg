#!/usr/bin/env python3
"""Static invariants for infra-pkg nFPM recipes (single-tree layout).

Every top-level directory holding a Makefile is a package. Arch-parameterized
packages build via `make one ARCH=<amd64|arm64>` with manifests using
`arch: "${ARCH}"`; noarch-style packages (kafka, jmx-exporter, pev2,
grafana-plugins) build once with `arch: "all"`. Packages with genuinely
different per-arch metadata split into `<base>.amd64.yaml` + `<base>.arm64.yaml`.
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
# Published package names are an upgrade ABI; v2ray historically shipped as vray.
PACKAGE_NAME_ALIASES = {"v2ray": {"vray"}, "ferretdb": {"ferretdb2"}}
PACKAGE_FORMATS = {"deb", "rpm"}
OVERRIDE_LIST_FIELDS = {
    "conflicts",
    "depends",
    "provides",
    "recommends",
    "replaces",
    "suggests",
}

SPLIT_RE = re.compile(r"^(?P<base>.+)\.(?P<arch>amd64|arm64)\.ya?ml$")


def package_dirs() -> List[Path]:
    return sorted(p.parent for p in ROOT.glob("*/Makefile"))


def package_manifests() -> Iterable[Path]:
    for pkg in package_dirs():
        yield from sorted(pkg.glob("*.yaml"))


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
    release = data.get("release")
    if release is None or str(release).strip() == "":
        errors.append(f"{rel}: missing release")

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

    for field in ("conflicts", "replaces"):
        if name in (data.get(field) or []):
            errors.append(f"{rel}: package {field} itself ({name})")

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
            for field in ("conflicts", "replaces"):
                if name in (override.get(field) or []):
                    errors.append(f"{rel}: overrides.{packager} package {field} itself ({name})")

    scripts = data.get("scripts") or {}
    if not isinstance(scripts, dict):
        errors.append(f"{rel}: scripts must be a mapping")
        scripts = {}
    else:
        for phase, source in scripts.items():
            script_path = path.parent / str(source)
            if not script_path.is_file():
                errors.append(f"{rel}: {phase} script does not exist: {source}")

    rpm = data.get("rpm") or {}
    rpm_scripts = rpm.get("scripts") or {} if isinstance(rpm, dict) else {}
    if not isinstance(rpm_scripts, dict):
        errors.append(f"{rel}: rpm.scripts must be a mapping")
    else:
        for phase, source in rpm_scripts.items():
            script_path = path.parent / str(source)
            if not script_path.is_file():
                errors.append(f"{rel}: rpm.{phase} script does not exist: {source}")

    destinations = set()
    units: List[str] = []
    uses_arch_var = False
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

        owner, group, mode = file_info(entry)
        entry_type = entry.get("type")
        if destination.endswith(".service") and "/systemd/system/" in destination:
            units.append(Path(destination).name)
            expected = f"/usr/lib/systemd/system/{Path(destination).name}"
            if destination != expected:
                errors.append(f"{rel}: vendor unit must use {expected}, found {destination}")
            if entry_type not in (None, "file"):
                errors.append(f"{rel}: systemd unit must be an ordinary file: {destination}")
            if (owner, group, mode) != ("root", "root", 0o644):
                errors.append(f"{rel}: systemd unit must be root:root 0644: {destination}")

        if destination.startswith("/etc/default/"):
            if owner != "root":
                errors.append(f"{rel}: /etc/default file must be owned by root: {destination}")
            if mode is None or mode & 0o111:
                errors.append(f"{rel}: /etc/default file must not be executable: {destination}")

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
            for pattern, label in (
                (r"&>", "bash-only &> redirection"),
                (r"\[\[(?!:)", "bash-only [[ test"),
            ):
                if re.search(pattern, text):
                    errors.append(f"{path.relative_to(ROOT)}: {label} under /bin/sh")


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
        version = re.sub(r"-(?:alpha|beta|rc)\.\d+$", "", version)
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

        package = make_variable(text, "PACKAGE")
        version = make_variable(text, "VERSION")
        release = make_variable(text, "RELEASE")
        if not package:
            continue
        for manifest in sorted(pkg.glob("*.yaml")):
            try:
                data = yaml.safe_load(manifest.read_text(encoding="utf-8"))
            except Exception:
                continue
            if not isinstance(data, dict) or not {"name", "version", "contents"}.issubset(data):
                continue
            manifest_name = str(data["name"])
            aliases = PACKAGE_NAME_ALIASES.get(pkg.name, set())
            if (
                manifest_name != package
                and manifest_name.replace("-", "_") != package
                and manifest_name not in aliases
            ):
                continue
            mrel = manifest.relative_to(ROOT)
            manifest_version = str(data["version"])
            if version and comparable_version(package, version) != comparable_version(package, manifest_version):
                errors.append(
                    f"{mrel}: version {manifest_version} differs from Makefile VERSION={version}"
                )
            manifest_release = str(data.get("release", ""))
            if release and release != manifest_release:
                errors.append(
                    f"{mrel}: release {manifest_release} differs from Makefile RELEASE={release}"
                )


def main() -> int:
    errors: List[str] = []
    versions: Dict[str, set] = defaultdict(set)
    artifacts: Dict[Tuple[Path, str], List[Path]] = defaultdict(list)
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
        makefile_text = (path.parent / "Makefile").read_text(encoding="utf-8")
        arch_pkg = is_arch_parameterized(makefile_text)
        name, version, release = lint_manifest(path, data, errors, arch_pkg)
        versions[name].add((version, release))
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
            rendered = ", ".join(f"{version}-{release}" for version, release in sorted(values))
            errors.append(f"{name}: inconsistent manifest versions: {rendered}")

    lint_split_manifests(errors)
    lint_shell(errors)
    lint_makefiles(errors)

    if errors:
        for error in errors:
            print(f"ERROR: {error}", file=sys.stderr)
        print(f"lint failed with {len(errors)} error(s)", file=sys.stderr)
        return 1
    print(f"lint passed: {count} nFPM manifests across {len(package_dirs())} packages")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
