# v2.7.0 was fetched from the authenticated draft release for local acceptance.
# Public URLs become available when upstream publishes it; the shared cache is pinned.
# Download the upstream SILO Console native DEB/RPM packages without repacking.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
REPONAME=pgsty/silo-console
PACKAGE=silo-console
VERSION=2.7.0
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=silo-console_2.7.0_linux_amd64.deb
DEB_FILE_arm64=silo-console_2.7.0_linux_arm64.deb
RPM_FILE_amd64=silo-console_2.7.0_linux_amd64.rpm
RPM_FILE_arm64=silo-console_2.7.0_linux_arm64.rpm
DEB_URL_amd64=https://github.com/pgsty/silo-console/releases/download/v$(VERSION)/silo-console_2.7.0_linux_amd64.deb
DEB_URL_arm64=https://github.com/pgsty/silo-console/releases/download/v$(VERSION)/silo-console_2.7.0_linux_arm64.deb
RPM_URL_amd64=https://github.com/pgsty/silo-console/releases/download/v$(VERSION)/silo-console_2.7.0_linux_amd64.rpm
RPM_URL_arm64=https://github.com/pgsty/silo-console/releases/download/v$(VERSION)/silo-console_2.7.0_linux_arm64.rpm
SHA256_DEB_amd64=92f4aa6f01014696befedc715f6e7ce4cf8ae6797c83d924e276c9834bc0e29e
SHA256_DEB_arm64=36b53342f31a4c49d84d7dfb96e409bb109467503f7eeb8a3fbb545c417cc0c5
SHA256_RPM_amd64=1b0f53a180466d7d0a2dd2ed6c1ff2520d8871148be62c7df6276fb0df042070
SHA256_RPM_arm64=daa57124922004c5a94df99d16feade824b1160b627485e15416580bfdbb6beb

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
