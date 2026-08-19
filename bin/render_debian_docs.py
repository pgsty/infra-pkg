#!/usr/bin/env python3
"""Render Debian copyright and changelog files from an nFPM manifest.

The generated files live only for the duration of one package build.  This
keeps the Debian changelog version synchronized with nFPM while copying the
actual upstream license and notice texts into the mandatory copyright file.
"""

from __future__ import annotations

import os
import re
import sys
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, Iterable, List, NoReturn, Tuple

try:
    import yaml
except ImportError:
    print("PyYAML is required to render Debian package documentation", file=sys.stderr)
    raise SystemExit(2)


LEGAL_DOCUMENT_RE = re.compile(
    r"^(?:licen[cs]e(?:s)?|copying|copyright|notice|third-party-licenses)(?:[._-].*)?$",
    re.I,
)
SEMVER_RE = re.compile(
    r"^[vV]?(\d+)(?:\.(\d+))?(?:\.(\d+))?"
    r"(?:-([0-9A-Za-z.-]+))?(?:\+([0-9A-Za-z.-]+))?$"
)


def fail(message: str) -> NoReturn:
    print(f"render_debian_docs: {message}", file=sys.stderr)
    raise SystemExit(2)


def load_manifest(path: Path) -> Dict[str, Any]:
    try:
        data = yaml.safe_load(path.read_text(encoding="utf-8"))
    except (OSError, yaml.YAMLError) as exc:
        fail(f"cannot read {path}: {exc}")
    if not isinstance(data, dict):
        fail(f"{path} is not a package manifest")
    return data


def debian_version(data: Dict[str, Any]) -> str:
    raw_version = str(data.get("version", "")).strip()
    match = SEMVER_RE.fullmatch(raw_version)
    if not match:
        fail(f"unsupported semver value: {raw_version!r}")

    major, minor, patch, embedded_prerelease, embedded_metadata = match.groups()
    version = f"{major}.{minor or '0'}.{patch or '0'}"
    prerelease = str(data.get("prerelease") or embedded_prerelease or "").strip()
    metadata = str(data.get("version_metadata") or embedded_metadata or "").strip()
    release = str(data.get("release", "")).strip()
    if prerelease:
        version += f"~{prerelease}"
    if metadata:
        version += f"+{metadata}"
    if release:
        version += f"-{release}"
    return version


def build_timestamp() -> datetime:
    source_date_epoch = os.environ.get("SOURCE_DATE_EPOCH")
    if source_date_epoch:
        try:
            return datetime.fromtimestamp(int(source_date_epoch), timezone.utc)
        except (ValueError, OSError, OverflowError):
            fail(f"invalid SOURCE_DATE_EPOCH: {source_date_epoch!r}")
    return datetime.now(timezone.utc).replace(microsecond=0)


def legal_documents(manifest: Path, data: Dict[str, Any]) -> List[Tuple[str, str]]:
    name = str(data.get("name", "")).strip()
    prefix = f"/usr/share/doc/{name}/"
    documents: List[Tuple[str, str]] = []
    seen: set[Path] = set()
    for entry in data.get("contents") or []:
        if not isinstance(entry, dict):
            continue
        destination = str(entry.get("dst", ""))
        basename = Path(destination.rstrip("/")).name
        if not destination.startswith(prefix) or not LEGAL_DOCUMENT_RE.fullmatch(basename):
            continue
        raw_source = str(entry.get("src", ""))
        if raw_source == "${NFPM_COPYRIGHT}":
            continue
        source = os.path.expandvars(raw_source)
        if not source or "$" in source:
            fail(f"{manifest}: unresolved legal document source for {destination}")
        source_path = Path(source)
        if not source_path.is_absolute():
            source_path = manifest.parent / source_path
        source_path = source_path.resolve()
        if source_path in seen:
            continue
        if not source_path.is_file():
            fail(f"{manifest}: legal document does not exist: {source}")
        seen.add(source_path)
        documents.append((basename, source_path.read_text(encoding="utf-8", errors="replace")))
    if not documents:
        fail(f"{manifest}: no packaged LICENSE, COPYING, or NOTICE document")
    return documents


def dep5_lines(text: str) -> Iterable[str]:
    for line in text.rstrip().splitlines():
        yield " ." if not line else f" {line}"


def render_copyright(manifest: Path, data: Dict[str, Any], destination: Path) -> None:
    name = str(data.get("name", "")).strip()
    homepage = str(data.get("homepage", "")).strip()
    license_expression = str(data.get("license", "")).strip()
    documents = legal_documents(manifest, data)
    lines = [
        "Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/",
        f"Upstream-Name: {name}",
        f"Source: {homepage}",
        "Comment: Generated from the verbatim upstream legal documents shipped in this package.",
        "",
        "Files: *",
        "Copyright: Upstream authors and contributors; see the notices below.",
        f"License: {license_expression}",
    ]
    for index, (label, content) in enumerate(documents):
        if index:
            lines.append(" .")
        lines.append(f" ----- {label} -----")
        lines.extend(dep5_lines(content))
    destination.write_text("\n".join(lines) + "\n", encoding="utf-8")


def render_changelog(data: Dict[str, Any], destination: Path) -> None:
    timestamp = build_timestamp().isoformat().replace("+00:00", "Z")
    entry = [{
        "deb": {"urgency": "medium", "distributions": ["stable"]},
        "semver": debian_version(data),
        "date": timestamp,
        "packager": str(data.get("maintainer", "")).strip(),
        "changes": [{"note": "Repackaged upstream release for PGSTY."}],
    }]
    destination.write_text(yaml.safe_dump(entry, sort_keys=False), encoding="utf-8")


def render_manifest(manifest: Path, output_dir: Path, packager: str) -> None:
    text = manifest.read_text(encoding="utf-8")
    if "${NFPM_CHANGELOG}" not in text or "${NFPM_COPYRIGHT}" not in text:
        fail(f"{manifest}: missing generated-document placeholders")
    changelog = str(output_dir / "changelog.yaml") if packager == "deb" else ""
    copyright_file = str(output_dir / "copyright") if packager == "deb" else "/dev/null"
    text = text.replace("${NFPM_CHANGELOG}", changelog)
    text = text.replace("${NFPM_COPYRIGHT}", copyright_file)
    (output_dir / "manifest.yaml").write_text(text, encoding="utf-8")


def main() -> int:
    if len(sys.argv) != 4 or sys.argv[3] not in {"deb", "rpm"}:
        print("usage: render_debian_docs.py MANIFEST OUTPUT_DIR PACKAGER", file=sys.stderr)
        return 2
    manifest = Path(sys.argv[1]).resolve()
    output_dir = Path(sys.argv[2]).resolve()
    packager = sys.argv[3]
    output_dir.mkdir(parents=True, exist_ok=True)
    data = load_manifest(manifest)
    if packager == "deb":
        render_copyright(manifest, data, output_dir / "copyright")
        render_changelog(data, output_dir / "changelog.yaml")
    render_manifest(manifest, output_dir, packager)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
