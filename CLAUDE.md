# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This repository builds RPM and DEB packages for the Pigsty observability stack (Prometheus, Grafana ecosystem, VictoriaMetrics, exporters, and related tools). Packages are built for both `amd64` (x86_64) and `arm64` (aarch64) architectures.

## Update SOP (Read This First)

For any package update work (version discovery, proxy downloads, tarball caching, Makefile/nFPM bumps, building, artifact verification, README + external docs updates), follow:


## Build Commands

Build all packages (each package builds every architecture it declares):
```bash
make all
```

Build every package for a single architecture:
```bash
make amd64
make arm64
```

Build a specific package (both architectures, or once for noarch):
```bash
make prometheus
make victoria-metrics
make duckdb
make etcd
# every top-level directory with a Makefile is a package target
```

Build a single package for one architecture:
```bash
cd prometheus && make one ARCH=amd64
cd prometheus && make one ARCH=arm64
```

## Architecture

### Directory Structure (single tree)
- `<package>/` - One top-level directory per package (any dir with a `Makefile`)
- `bin/` - All helper scripts: pinned `nfpm` wrapper (version in `.nfpm-version`),
  `lint_specs.py`, `pkg_update.py`, `check_update.py`, `infra_update_all.py`,
  upgrade test scripts (`check-deb-unit-upgrade`, `check-rpm-unit-upgrade`, `fake-systemctl`)
- `tarball/` - Shared download cache for all architectures (filenames are arch-qualified)
- `dist/` - Build output directory
  - `rpm/` - All RPM packages (x86_64 + aarch64 + noarch)
  - `deb/` - All DEB packages (amd64 + arm64 + all)

### Package Build Pattern
Each package follows a consistent structure under `<package>/`:
- `Makefile` - ARCH-parameterized: `ARCH ?= amd64`, `ARCHS ?= amd64 arm64`,
  `RARCH` (x86_64/aarch64), per-arch variables as `VAR_amd64=`/`VAR_arm64=` +
  `VAR=$(VAR_$(ARCH))` selectors; `make` loops `ARCHS`, `make one ARCH=x` builds one arch.
  Noarch-style packages (kafka, jmx-exporter, pev2, grafana-plugins) have no ARCH loop.
- `nfpm.yaml` - single nFPM config with `arch: "${ARCH}"` (env-expanded by nfpm);
  noarch packages use `arch: "all"`. Packages with genuinely different per-arch
  metadata split into `<base>.amd64.yaml` + `<base>.arm64.yaml` (asciinema, postgrest).
- `src/` - Package resources (systemd units, config files, install scripts)
  - `preinstall.sh`, `postinstall.sh` - Install hooks
  - `preremove.sh`, `postremove.sh` - Uninstall hooks
  - `service` - systemd service file (installed to /usr/lib/systemd/system)
  - `default` - Default environment config (installed to /etc/default/<name>)

### Build Process
1. `download` - Fetch upstream artifact (checks `../tarball/` cache first)
2. `verify` - Check pinned SHA256 where configured
3. `extract` - Extract tarball contents
4. `build` - Run `../bin/nfpm` (version-pinned wrapper) with `ARCH`/`RARCH` exported,
   output to `../dist/rpm/` and `../dist/deb/`
5. `clean` - Remove temporary files

Packages use [nFPM](https://nfpm.goreleaser.com/) for building both RPM and DEB from a single configuration. Run `make lint` (bin/lint_specs.py) after any packaging change.

### Adding/Updating a Package

At a minimum:
1. Confirm upstream latest version (and tag naming rules)
2. Download artifacts through proxy into the shared `tarball/` cache
   (cache filenames must be architecture-qualified, e.g. `foo-v1.2.3-linux-arm64`)
3. Update versions in `Makefile` + `nfpm*.yaml`
4. Build and verify output versions/architectures, run `make lint`
5. Update README + external docs release notes

### Claude Package Notes

For the `claude` package:
1. Always download versioned Claude artifacts through the local proxy on port `8118`, for example `curl --proxy http://127.0.0.1:8118 ...`.
2. Verify the downloaded binary really matches the intended Claude version before building packages.

### Sync with Build Server
```bash
make push   # rsync to build server
make pull   # rsync from build server
```

## Build

When you are asked to "build", it means, you have to run `make xxx` for the corresponding packages.

We usually build in batch, around 1~3 build per month, and make those listed in the latest changelog.

## Stash

when you are asked to "stash", it means, you have to collect built / downloaded artifacts, and put it into tmp/stash directory.
All artifacts now live in `dist/deb/` and `dist/rpm/`; split them by filename arch suffix:

- apt-infra: `dist/deb/*_{amd64,arm64,all}.deb`
- yum-infra-x86_64: `dist/rpm/*.{x86_64,noarch}.rpm`
- yum-infra-aarch64: `dist/rpm/*.{aarch64,noarch}.rpm`

## Place

when you are asked to "place", copy these stashed artifacts to the corresponding directories:

- apt-infra -> ~/pgsty/repo/apt/infra/stash
- yum-infra-x86_64 -> ~/pgsty/repo/yum/infra/x86_64/
- yum-infra-aarch64 -> ~/pgsty/repo/yum/infra/aarch64/


## Purge 

when you are asked to "purge", you have to validate:

- ~/pgsty/repo/yum/infra/x86_64/
- ~/pgsty/repo/yum/infra/aarch64/

always have one and only one latest version of each package.
You shall not remove any existing rpm packages, but instead, list the obsolete versions to be removed, 
generate a tmp/purge.sh script to remove them one by one explicitly, but never run that script without my confirmation even in YOLO mode.


## Update Change log

If you are asked to update the infra package change log, update accordingly: 

- ~/pgsty/pigsty.cc/content/docs/repo/infra/log.md    # change log in Simplified chinese
- ~/pgsty/pigsty.cc/content/docs/repo/infra/list.md   # current version in Simplified chinese

- ~/pgsty/pigsty.io/content/docs/repo/infra/log.md    # change log in English
- ~/pgsty/pigsty.io/content/docs/repo/infra/list.md   # current version in English

- ~/pgsty/pgext/content/release/infra.md    # change log in English
- ~/pgsty/pgext/content/release/infra.zh.md    # change log in Chinese
- ./README.md 
