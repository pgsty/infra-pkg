# Preserve the official PGEXT native RPM/DEB packages.
ARCH ?= amd64
ARCHS ?= amd64 arm64
RARCH = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
REPONAME=pgsty/pgext
PACKAGE=pgext
VERSION=1.7.3
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=pgext_1.7.3-1PGSTY_amd64.deb
DEB_URL_amd64=https://github.com/pgsty/pgext/releases/download/v1.7.3/pgext_1.7.3-1PGSTY_amd64.deb
RPM_FILE_amd64=pgext-1.7.3-1PGSTY.x86_64.rpm
RPM_URL_amd64=https://github.com/pgsty/pgext/releases/download/v1.7.3/pgext-1.7.3-1PGSTY.x86_64.rpm
DEB_FILE_arm64=pgext_1.7.3-1PGSTY_arm64.deb
DEB_URL_arm64=https://github.com/pgsty/pgext/releases/download/v1.7.3/pgext_1.7.3-1PGSTY_arm64.deb
RPM_FILE_arm64=pgext-1.7.3-1PGSTY.aarch64.rpm
RPM_URL_arm64=https://github.com/pgsty/pgext/releases/download/v1.7.3/pgext-1.7.3-1PGSTY.aarch64.rpm
SHA256_DEB_amd64=677bf024aa5b7890d1ba2f3a5a73a681d01499b0a46d9ff6c35299b81ca7c342
SHA256_RPM_amd64=2a1e7d4facecea005afa655d8e3348f5c4a73d899a85424c2d65ef9765af923e
SHA256_DEB_arm64=c7638056ae047d9ad8c441aff1dd530db1c71da47d04004d321522fc1655ccc2
SHA256_RPM_arm64=fc156ce4208082e4ecf7cfe7159f470b169113f1615a7d6b8f3b28d00136a252

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:
.PHONY: default all one get link download verify build verify-dist clean
