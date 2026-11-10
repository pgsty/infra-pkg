# Preserve the official PGEXT native RPM/DEB packages.
ARCH ?= amd64
ARCHS ?= amd64 arm64
RARCH = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
REPONAME=pgsty/pgext
PACKAGE=pgext
VERSION=1.6.0
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=pgext_1.6.0-1PGSTY_amd64.deb
DEB_URL_amd64=https://github.com/pgsty/pgext/releases/download/v1.6.0/pgext_1.6.0-1PGSTY_amd64.deb
RPM_FILE_amd64=pgext-1.6.0-1PGSTY.x86_64.rpm
RPM_URL_amd64=https://github.com/pgsty/pgext/releases/download/v1.6.0/pgext-1.6.0-1PGSTY.x86_64.rpm
DEB_FILE_arm64=pgext_1.6.0-1PGSTY_arm64.deb
DEB_URL_arm64=https://github.com/pgsty/pgext/releases/download/v1.6.0/pgext_1.6.0-1PGSTY_arm64.deb
RPM_FILE_arm64=pgext-1.6.0-1PGSTY.aarch64.rpm
RPM_URL_arm64=https://github.com/pgsty/pgext/releases/download/v1.6.0/pgext-1.6.0-1PGSTY.aarch64.rpm
SHA256_DEB_amd64=37869f7d92db56717a5e2b5d65160246a3468c3c8dd968961458d9cf4355136e
SHA256_RPM_amd64=8ef1c1ce1ef8735259d3f1ab93cea0ae82133ee334eeb42c9cddc6aeaa901594
SHA256_DEB_arm64=d762ca54dd6c5b2e58dbc7eb2464d9b84d724c1a786d4c11a9cf07375ff6f25b
SHA256_RPM_arm64=5c1d0157f6bbcda5d044a404e396dacc26f3b0e0f108b3f72d758df7bf2d9d59

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:
.PHONY: default all one get link download verify build verify-dist clean
