#==============================================================#
# File      :   Makefile
# Desc      :   Download official Silo DEB/RPM packages
# Path      :   silo/Makefile
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

# Release ID 442493487; public assets verified after the authorized draft intake.
# The release tag and both binaries resolve to commit 44e848fedf8cec3d8c0da4b1aa8422390a2b7a8b.
VENDOR_DIRECT=1
PACKAGE=silo
VERSION=20261112000000.0.0
TAG=RELEASE.2026-11-12T00-00-00Z
RELEASE=1PGSTY
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=silo_20261112000000.0.0-1PGSTY_amd64.deb
DEB_FILE_arm64=silo_20261112000000.0.0-1PGSTY_arm64.deb
RPM_FILE_amd64=silo-20261112000000.0.0-1PGSTY.x86_64.rpm
RPM_FILE_arm64=silo-20261112000000.0.0-1PGSTY.aarch64.rpm
DEB_URL_amd64=https://github.com/pgsty/silo/releases/download/RELEASE.2026-11-12T00-00-00Z/silo_20261112000000.0.0-1PGSTY_amd64.deb
DEB_URL_arm64=https://github.com/pgsty/silo/releases/download/RELEASE.2026-11-12T00-00-00Z/silo_20261112000000.0.0-1PGSTY_arm64.deb
RPM_URL_amd64=https://github.com/pgsty/silo/releases/download/RELEASE.2026-11-12T00-00-00Z/silo-20261112000000.0.0-1PGSTY.x86_64.rpm
RPM_URL_arm64=https://github.com/pgsty/silo/releases/download/RELEASE.2026-11-12T00-00-00Z/silo-20261112000000.0.0-1PGSTY.aarch64.rpm
SHA256_DEB_amd64=232f59133179547a9dce6844dfbe41f222b5fe3eb53ba1d0a3904bb88c3eabcf
SHA256_DEB_arm64=690943d08f8ce863a4c9569dc58b139945d6a33e2eae8a1907420ac003b456ae
SHA256_RPM_amd64=72ce9256c4a92e88838f7e11c089a6c9cde707b15f441fcdd4580879c1c86982
SHA256_RPM_arm64=1f5378b9d55d2de4a52046fa96e470642a67c37c612c1165852f22eccd0f7c98

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
