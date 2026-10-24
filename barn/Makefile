# Download upstream Barn native packages without repacking.
# Barn 0.x releases use the upstream prerelease channel; v0.9.1 is selected explicitly.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
REPONAME=pgsty/barn
PACKAGE=barn
VERSION=0.9.1
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=barn_0.9.1_linux_amd64.deb
DEB_FILE_arm64=barn_0.9.1_linux_arm64.deb
RPM_FILE_amd64=barn_0.9.1_linux_amd64.rpm
RPM_FILE_arm64=barn_0.9.1_linux_arm64.rpm
DEB_URL_amd64=https://github.com/pgsty/barn/releases/download/v0.9.1/barn_0.9.1_linux_amd64.deb
DEB_URL_arm64=https://github.com/pgsty/barn/releases/download/v0.9.1/barn_0.9.1_linux_arm64.deb
RPM_URL_amd64=https://github.com/pgsty/barn/releases/download/v0.9.1/barn_0.9.1_linux_amd64.rpm
RPM_URL_arm64=https://github.com/pgsty/barn/releases/download/v0.9.1/barn_0.9.1_linux_arm64.rpm
SHA256_DEB_amd64=30d4210db3fc3f92c4bbb8d677e5508c25ba365e8fcc0cbf19351f38f2918406
SHA256_DEB_arm64=7acdf2522ad5e47fa8766bbdd590b5b964a4a3f574c6292240f981821cd97ecb
SHA256_RPM_amd64=e78a43f9d5da30ca1db79b533f57e1d1809454bfb2991e2676b3f9d44ed56792
SHA256_RPM_arm64=48b332d8370d00c6a0717c8d27a7d3a51d79ea4dbf9fa709294bc46eb5aa9fab

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
