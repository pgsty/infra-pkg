# Preserve the official PGEXT native RPM/DEB packages.
ARCH ?= amd64
ARCHS ?= amd64 arm64
RARCH = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
REPONAME=pgsty/pgext
PACKAGE=pgext
VERSION=1.7.1
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=pgext_1.7.1-1PGSTY_amd64.deb
DEB_URL_amd64=https://github.com/pgsty/pgext/releases/download/v1.7.1/pgext_1.7.1-1PGSTY_amd64.deb
RPM_FILE_amd64=pgext-1.7.1-1PGSTY.x86_64.rpm
RPM_URL_amd64=https://github.com/pgsty/pgext/releases/download/v1.7.1/pgext-1.7.1-1PGSTY.x86_64.rpm
DEB_FILE_arm64=pgext_1.7.1-1PGSTY_arm64.deb
DEB_URL_arm64=https://github.com/pgsty/pgext/releases/download/v1.7.1/pgext_1.7.1-1PGSTY_arm64.deb
RPM_FILE_arm64=pgext-1.7.1-1PGSTY.aarch64.rpm
RPM_URL_arm64=https://github.com/pgsty/pgext/releases/download/v1.7.1/pgext-1.7.1-1PGSTY.aarch64.rpm
SHA256_DEB_amd64=7ecdf3ca514173555f1f341c5942909dea5123914e0d975714fe633acc02d0af
SHA256_RPM_amd64=f1a011a5efd4b79009d6f3c3758fc35d3c31d920b54356a540be0357779368ea
SHA256_DEB_arm64=b81099a0b3388bde730555053fe6263ffee3dada5b3542dc820d1215a86fa9f8
SHA256_RPM_arm64=ce76ea24a8cc9afee0d79ea4b26fb4eb684286535b480682fbca557dabea1f00

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:
.PHONY: default all one get link download verify build verify-dist clean
