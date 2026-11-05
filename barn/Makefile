# Download upstream Barn native packages without repacking.
# Barn 0.x releases use the upstream prerelease channel; v0.9.1 is selected explicitly.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
REPONAME=pgsty/barn
PACKAGE=barn
VERSION=0.9.3
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=barn_0.9.3_linux_amd64.deb
DEB_FILE_arm64=barn_0.9.3_linux_arm64.deb
RPM_FILE_amd64=barn_0.9.3_linux_amd64.rpm
RPM_FILE_arm64=barn_0.9.3_linux_arm64.rpm
DEB_URL_amd64=https://github.com/pgsty/barn/releases/download/v0.9.3/barn_0.9.3_linux_amd64.deb
DEB_URL_arm64=https://github.com/pgsty/barn/releases/download/v0.9.3/barn_0.9.3_linux_arm64.deb
RPM_URL_amd64=https://github.com/pgsty/barn/releases/download/v0.9.3/barn_0.9.3_linux_amd64.rpm
RPM_URL_arm64=https://github.com/pgsty/barn/releases/download/v0.9.3/barn_0.9.3_linux_arm64.rpm
SHA256_DEB_amd64=5e124a21774ffadfcfae375fe1a568f157ebec4acb6645efb2e3833c8fe313e7
SHA256_DEB_arm64=c5b305a89c16d2f3d9dec42a8de1c1b303f7f9fb5efe833a0db306109aadd939
SHA256_RPM_amd64=c1f0c15ee3e1ed5fec5a74211fcbb00847ab077cbd461ac9c1ca41be973f6adb
SHA256_RPM_arm64=5f0e50b5f8499d1605d2f49bb05f6c3d0a8db1e3aa6f7c7efaff6d8d7ddf8729

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
