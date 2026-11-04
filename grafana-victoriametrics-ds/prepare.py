#!/usr/bin/env python3
"""Validate upstream plugin metadata and retain one Linux backend for packaging."""

import argparse
import json
from pathlib import Path
import struct


PLUGIN_ID = "victoriametrics-metrics-datasource"
EXECUTABLE = "victoriametrics_metrics_backend_plugin"
# Changes here require reviewing the matching Debian/RPM constraints in nfpm.yaml.
GRAFANA_DEPENDENCY = ">=11.6.11 <12 || >=12.0.10 <12.1 || >=12.1.7 <12.2 || >=12.2.5"
ELF_MACHINE = {"amd64": 62, "arm64": 183}


def prepare(directory: Path, version: str, arch: str) -> None:
    plugin = json.loads((directory / "plugin.json").read_text())
    expected = {
        "id": PLUGIN_ID,
        "type": "datasource",
        "backend": True,
        "executable": EXECUTABLE,
    }
    for key, value in expected.items():
        if plugin.get(key) != value:
            raise ValueError(f"unexpected plugin {key}: {plugin.get(key)!r}")
    if plugin.get("info", {}).get("version") != version:
        raise ValueError(f"plugin.json does not match package version {version}")
    if plugin.get("dependencies", {}).get("grafanaDependency") != GRAFANA_DEPENDENCY:
        raise ValueError("upstream Grafana requirements changed; review nfpm.yaml")

    target = directory / f"{EXECUTABLE}_linux_{arch}"
    if target.is_symlink() or not target.is_file():
        raise ValueError(f"missing regular backend file: {target}")
    with target.open("rb") as stream:
        header = stream.read(20)
    if len(header) != 20 or header[:6] != b"\x7fELF\x02\x01":
        raise ValueError(f"backend is not a 64-bit little-endian ELF: {target}")
    if struct.unpack_from("<H", header, 18)[0] != ELF_MACHINE[arch]:
        raise ValueError(f"backend ELF architecture does not match {arch}")
    if not target.stat().st_mode & 0o111:
        raise ValueError(f"backend is not executable: {target}")

    backends = list(directory.glob(f"{EXECUTABLE}_*"))
    if any(path.is_symlink() or not path.is_file() for path in backends):
        raise ValueError("unexpected non-regular backend entry")
    for path in backends:
        if path != target:
            path.unlink()
    # Pruning changes the signed file set; ship an explicitly unsigned plugin.
    (directory / "MANIFEST.txt").unlink(missing_ok=True)
    print(f"Validated {PLUGIN_ID} {version} for {arch}; retained one backend")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("directory", type=Path)
    parser.add_argument("version")
    parser.add_argument("arch", choices=ELF_MACHINE)
    args = parser.parse_args()
    prepare(args.directory, args.version, args.arch)


if __name__ == "__main__":
    main()
