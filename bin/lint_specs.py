#!/usr/bin/env python3
"""Static invariants for infra-pkg nFPM recipes and shared package sources."""

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
ARCHES = ("amd64", "arm64", "noarch")
SHARED_SOURCE_EXCEPTIONS = {("k3s", Path("AIRGAP.md"))}
# Published package names are an upgrade ABI; v2ray historically shipped as vray.
PACKAGE_NAME_ALIASES = {"v2ray": {"vray"}, "ferretdb": {"ferretdb2"}}
PACKAGE_FORMATS = {"deb", "rpm"}
SINGLE_ARCH_PACKAGE_EXCEPTIONS = {"kafka"}
OVERRIDE_LIST_FIELDS = {
    "conflicts",
    "depends",
    "provides",
    "recommends",
    "replaces",
    "suggests",
}
def package_manifests() -> Iterable[Path]:
    for arch in ARCHES:
        yield from sorted((ROOT / arch).glob("*/*.yaml"))


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


def lint_manifest(path: Path, data: Dict[str, Any], errors: List[str]) -> Tuple[str, str, str]:
    rel = path.relative_to(ROOT)
    name = str(data.get("name", ""))
    version = str(data.get("version", ""))
    release = data.get("release")
    if release is None or str(release).strip() == "":
        errors.append(f"{rel}: missing release")

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
    contents = data.get("contents") or []
    if not isinstance(contents, list):
        errors.append(f"{rel}: contents must be a list")
        contents = []
    for entry in contents:
        if not isinstance(entry, dict):
            errors.append(f"{rel}: content entry must be a mapping")
            continue
        destination = str(entry.get("dst", ""))
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


def source_files(directory: Path, package: str) -> Dict[Path, bytes]:
    result: Dict[Path, bytes] = {}
    for path in sorted(directory.rglob("*")):
        if not path.is_file():
            continue
        relative = path.relative_to(directory)
        if (package, relative) in SHARED_SOURCE_EXCEPTIONS:
            continue
        result[relative] = path.read_bytes()
    return result


def lint_shared_sources(errors: List[str]) -> None:
    common = sorted(
        {p.name for p in (ROOT / "amd64").iterdir() if p.is_dir()}
        & {p.name for p in (ROOT / "arm64").iterdir() if p.is_dir()}
    )
    for package in common:
        left = ROOT / "amd64" / package / "src"
        right = ROOT / "arm64" / package / "src"
        if not left.is_dir() and not right.is_dir():
            continue
        if not left.is_dir() or not right.is_dir():
            errors.append(f"{package}: src directory exists for only one architecture")
            continue
        left_files = source_files(left, package)
        right_files = source_files(right, package)
        for relative in sorted(set(left_files) | set(right_files)):
            if relative not in left_files:
                errors.append(f"{package}: source only in arm64: {relative}")
            elif relative not in right_files:
                errors.append(f"{package}: source only in amd64: {relative}")
            elif left_files[relative] != right_files[relative]:
                errors.append(f"{package}: shared source differs by architecture: {relative}")


def lint_package_directories(errors: List[str]) -> None:
    packages = {
        arch: {
            path.parent.name
            for path in (ROOT / arch).glob("*/Makefile")
        }
        for arch in ("amd64", "arm64")
    }
    for package in sorted(packages["amd64"] ^ packages["arm64"]):
        present_arch = "amd64" if package in packages["amd64"] else "arm64"
        if package not in SINGLE_ARCH_PACKAGE_EXCEPTIONS:
            errors.append(f"{package}: package directory exists only in {present_arch}")
            continue
        manifests = []
        for path in sorted((ROOT / present_arch / package).glob("*.yaml")):
            try:
                data = yaml.safe_load(path.read_text(encoding="utf-8"))
            except Exception:
                continue
            if isinstance(data, dict) and {"name", "version", "contents"}.issubset(data):
                manifests.append((path, data))
        if not manifests or any(data.get("arch") != "all" for _path, data in manifests):
            errors.append(f"{package}: single-architecture directory must package arch: all")


def lint_shell(errors: List[str]) -> None:
    for arch in ARCHES:
        for path in sorted((ROOT / arch).glob("**/*.sh")):
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


def lint_makefiles(errors: List[str]) -> None:
    for arch in ARCHES:
        for path in sorted((ROOT / arch).glob("*/Makefile")):
            text = path.read_text(encoding="utf-8")
            configs: Dict[str, set] = {"rpm": set(), "deb": set()}
            if not re.search(r"^\.NOTPARALLEL:\s*$", text, re.M):
                errors.append(f"{path.relative_to(ROOT)}: missing .NOTPARALLEL build-race guard")
            for number, line in enumerate(text.splitlines(), 1):
                if "nfpm package" in line and not line.strip().startswith("../../bin/nfpm package"):
                    errors.append(f"{path.relative_to(ROOT)}:{number}: bypasses pinned nFPM wrapper")
                if "nfpm package" in line:
                    config_match = re.search(r"--config\s+(\S+)", line)
                    packager_match = re.search(r"--packager\s+(rpm|deb)", line)
                    if not config_match or not packager_match:
                        errors.append(f"{path.relative_to(ROOT)}:{number}: incomplete nFPM command")
                    else:
                        config = config_match.group(1)
                        packager = packager_match.group(1)
                        configs[packager].add(config)
                        if not (path.parent / config).is_file():
                            errors.append(
                                f"{path.relative_to(ROOT)}:{number}: missing nFPM config {config}"
                            )
                if "curl" in line and not line.lstrip().startswith(("#", "@echo")):
                    curl_args = line.split("curl", 1)[1]
                    has_fail = "--fail" in curl_args or re.search(r"(?:^|\s)-[A-Za-z]*f[A-Za-z]*", curl_args)
                    if not has_fail:
                        errors.append(f"{path.relative_to(ROOT)}:{number}: curl download must fail on HTTP errors")

            if configs["rpm"] != configs["deb"]:
                errors.append(
                    f"{path.relative_to(ROOT)}: RPM and DEB builds must use the same nFPM configs"
                )

            package = make_variable(text, "PACKAGE")
            version = make_variable(text, "VERSION")
            release = make_variable(text, "RELEASE")
            if not package:
                continue
            for manifest in sorted(path.parent.glob("*.yaml")):
                try:
                    data = yaml.safe_load(manifest.read_text(encoding="utf-8"))
                except Exception:
                    continue
                if not isinstance(data, dict) or not {"name", "version", "contents"}.issubset(data):
                    continue
                manifest_name = str(data["name"])
                aliases = PACKAGE_NAME_ALIASES.get(path.parent.name, set())
                if (
                    manifest_name != package
                    and manifest_name.replace("-", "_") != package
                    and manifest_name not in aliases
                ):
                    continue
                rel = manifest.relative_to(ROOT)
                manifest_version = str(data["version"])
                if version and comparable_version(package, version) != comparable_version(package, manifest_version):
                    errors.append(
                        f"{rel}: version {manifest_version} differs from Makefile VERSION={version}"
                    )
                manifest_release = str(data.get("release", ""))
                if release and release != manifest_release:
                    errors.append(
                        f"{rel}: release {manifest_release} differs from Makefile RELEASE={release}"
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
        name, version, release = lint_manifest(path, data, errors)
        versions[name].add((version, release))
        artifacts[(path.parent, name)].append(path)
        if path.name.endswith(("-deb.yaml", "-rpm.yaml")):
            errors.append(
                f"{path.relative_to(ROOT)}: split RPM/DEB manifests are forbidden; use one config with overrides"
            )
        if path.parts[-3] == "noarch" and data.get("arch") != "all":
            errors.append(f"{path.relative_to(ROOT)}: noarch manifest must use arch: all")

    for (directory, name), paths in sorted(artifacts.items()):
        if len(paths) > 1:
            rendered = ", ".join(path.name for path in paths)
            errors.append(
                f"{directory.relative_to(ROOT)}/{name}: one artifact has multiple nFPM manifests: {rendered}"
            )

    for name, values in sorted(versions.items()):
        if len(values) != 1:
            rendered = ", ".join(f"{version}-{release}" for version, release in sorted(values))
            errors.append(f"{name}: inconsistent manifest versions: {rendered}")

    lint_shared_sources(errors)
    lint_package_directories(errors)
    lint_shell(errors)
    lint_makefiles(errors)

    if errors:
        for error in errors:
            print(f"ERROR: {error}", file=sys.stderr)
        print(f"lint failed with {len(errors)} error(s)", file=sys.stderr)
        return 1
    print(f"lint passed: {count} nFPM manifests")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
