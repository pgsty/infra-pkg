# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This repository builds RPM and DEB packages for the Pigsty observability stack (Prometheus, Grafana ecosystem, VictoriaMetrics, exporters, and related tools). Packages are built for both `amd64` (x86_64) and `arm64` (aarch64) architectures.

## Build Commands

Build all packages for both architectures:
```bash
make all
```

Build for a specific architecture:
```bash
make amd64
make arm64
```

Build a specific component (builds for both architectures):
```bash
make prometheus
make victoria-metrics
make duckdb
make etcd
# See Makefile for full list of components
```

Build a single package for one architecture:
```bash
cd amd64/prometheus && make
cd arm64/prometheus && make
```

## Architecture

### Directory Structure
- `amd64/` - Package definitions for x86_64 architecture
- `arm64/` - Package definitions for aarch64 architecture
- `noarch/` - Architecture-independent packages (grafana-plugins, pev2)
- `dist/` - Build output directory
  - `rpm.x86_64/`, `rpm.aarch64/` - Built RPM packages
  - `deb.amd64/`, `deb.arm64/` - Built DEB packages
  - `noarch/` - Architecture-independent packages

### Package Build Pattern
Each package follows a consistent structure under `{arch}/{package}/`:
- `Makefile` - Defines version, download URL, and build targets
- `nfpm-rpm.yaml` - nFPM configuration for RPM packaging
- `nfpm-deb.yaml` - nFPM configuration for DEB packaging (sometimes `nfpm.yaml` for noarch)
- `src/` - Package resources (systemd units, config files, install scripts)
  - `preinstall.sh`, `postinstall.sh` - Install hooks
  - `preremove.sh`, `postremove.sh` - Uninstall hooks
  - `service` - systemd service file
  - `default` - Default environment config

### Build Process
1. `download` - Fetch upstream tarball (checks `../tarball/` cache first)
2. `extract` - Extract tarball contents
3. `build` - Run nFPM to create RPM and DEB packages
4. `clean` - Remove temporary files

Packages use [nFPM](https://nfpm.goreleaser.com/) for building both RPM and DEB from a single configuration.

### Adding/Updating a Package
1. Update `VERSION` in the package's Makefile
2. Run `make link` to verify the download URL
3. Run `make` to build (or `make get` to just download and extract)
4. Commit version bump

### Sync with Build Server
```bash
make push   # rsync to build server
make pull   # rsync from build server
```
