# Preserve the official PGEXT native RPM/DEB packages.
ARCH ?= amd64
ARCHS ?= amd64 arm64
RARCH = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
REPONAME=pgsty/pgext
PACKAGE=pgext
VERSION=1.7.2
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=pgext_1.7.2-1PGSTY_amd64.deb
DEB_URL_amd64=https://github.com/pgsty/pgext/releases/download/v1.7.2/pgext_1.7.2-1PGSTY_amd64.deb
RPM_FILE_amd64=pgext-1.7.2-1PGSTY.x86_64.rpm
RPM_URL_amd64=https://github.com/pgsty/pgext/releases/download/v1.7.2/pgext-1.7.2-1PGSTY.x86_64.rpm
DEB_FILE_arm64=pgext_1.7.2-1PGSTY_arm64.deb
DEB_URL_arm64=https://github.com/pgsty/pgext/releases/download/v1.7.2/pgext_1.7.2-1PGSTY_arm64.deb
RPM_FILE_arm64=pgext-1.7.2-1PGSTY.aarch64.rpm
RPM_URL_arm64=https://github.com/pgsty/pgext/releases/download/v1.7.2/pgext-1.7.2-1PGSTY.aarch64.rpm
SHA256_DEB_amd64=d88acbec63150b663c15f213e53685f2928e6969a65b5ac2b7f511d15382c354
SHA256_RPM_amd64=807d43dc804512090de4a7bec9a2d493cda7e99864522cc229a08e5970f670f7
SHA256_DEB_arm64=5e89a4ccc0a9b2160a6fda420213cca22e40373132a0e81e029261edc46d21f6
SHA256_RPM_arm64=1cf12e1dfde1cdff664b5f00503bfdf1b5561f394afc9273482c0735fc1469df

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:
.PHONY: default all one get link download verify build verify-dist clean
