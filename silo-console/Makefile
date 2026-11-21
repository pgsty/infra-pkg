# Download the upstream SILO Console native DEB/RPM packages without repacking.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
REPONAME=pgsty/silo-console
PACKAGE=silo-console
VERSION=2.7.2
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=silo-console_2.7.2_linux_amd64.deb
DEB_FILE_arm64=silo-console_2.7.2_linux_arm64.deb
RPM_FILE_amd64=silo-console_2.7.2_linux_amd64.rpm
RPM_FILE_arm64=silo-console_2.7.2_linux_arm64.rpm
DEB_URL_amd64=https://github.com/pgsty/silo-console/releases/download/v2.7.2/silo-console_2.7.2_linux_amd64.deb
DEB_URL_arm64=https://github.com/pgsty/silo-console/releases/download/v2.7.2/silo-console_2.7.2_linux_arm64.deb
RPM_URL_amd64=https://github.com/pgsty/silo-console/releases/download/v2.7.2/silo-console_2.7.2_linux_amd64.rpm
RPM_URL_arm64=https://github.com/pgsty/silo-console/releases/download/v2.7.2/silo-console_2.7.2_linux_arm64.rpm
SHA256_DEB_amd64=d2f1dae3cec8c36151d17e7c6198212a171acb43d1d7cbbbeb20529ea3700069
SHA256_DEB_arm64=831c0e89c98f03a14f40d1ff01a7c16410d2fd1722c8264e2288ca8439ce8b11
SHA256_RPM_amd64=5d122545042c481c717ab40d4481047eaee6f523eee0c39cb8becae136ce8d6b
SHA256_RPM_arm64=eb26c9e5c3be4d12ddb73a0a7ae8e099ca92807f7f3ae4eeecead00832cee84e

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
