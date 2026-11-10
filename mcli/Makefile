#==============================================================#
# File      :   Makefile
# Desc      :   Download official mcli DEB/RPM packages
# Path      :   mcli/Makefile
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=mcli
VERSION=20261109000000.0.0
TAG=RELEASE.2026-11-09T00-00-00Z
RELEASE=1
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=mcli_20261109000000.0.0_amd64.deb
DEB_FILE_arm64=mcli_20261109000000.0.0_arm64.deb
RPM_FILE_amd64=mcli-20261109000000.0.0-1.x86_64.rpm
RPM_FILE_arm64=mcli-20261109000000.0.0-1.aarch64.rpm
DEB_URL_amd64=https://github.com/pgsty/mc/releases/download/RELEASE.2026-11-09T00-00-00Z/mcli_20261109000000.0.0_amd64.deb
DEB_URL_arm64=https://github.com/pgsty/mc/releases/download/RELEASE.2026-11-09T00-00-00Z/mcli_20261109000000.0.0_arm64.deb
RPM_URL_amd64=https://github.com/pgsty/mc/releases/download/RELEASE.2026-11-09T00-00-00Z/mcli-20261109000000.0.0-1.x86_64.rpm
RPM_URL_arm64=https://github.com/pgsty/mc/releases/download/RELEASE.2026-11-09T00-00-00Z/mcli-20261109000000.0.0-1.aarch64.rpm
SHA256_DEB_amd64=7e4ec993791efa851a5ebbc691c5a17eec014d88c3787722a5f3fecbee197447
SHA256_DEB_arm64=8ddfba8c55e6a8fa06f9a3fef01093d04efad21bb9f7900e1dd0eaf624dc3747
SHA256_RPM_amd64=405a0b3bfd02289e107bf30a8c6c6d8307945fbe55b920a83df9b0923b6b6729
SHA256_RPM_arm64=598385d201ea1dff976ec05d58340e0b6c3727ba387acf30bc245fc8389781e8

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
