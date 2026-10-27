# Download the upstream SILO Console native DEB/RPM packages without repacking.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
REPONAME=pgsty/silo-console
PACKAGE=silo-console
VERSION=2.5.1
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=silo-console_$(VERSION)_linux_amd64.deb
DEB_FILE_arm64=silo-console_$(VERSION)_linux_arm64.deb
RPM_FILE_amd64=silo-console_$(VERSION)_linux_amd64.rpm
RPM_FILE_arm64=silo-console_$(VERSION)_linux_arm64.rpm
DEB_URL_amd64=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=97619a6e10e746ee5a3eb7ef2a67a50d362a5ff2f7cda2023a5ac415403352a5
SHA256_DEB_arm64=0f7008caf0cec113bf8d57575d930b393930f1cc2036071fedd77071bee87a61
SHA256_RPM_amd64=f691031579b97e8940800e9254fb3a698a21d78bff3294c50de3565b4f528d8c
SHA256_RPM_arm64=d47944ad79a1b9227072539de70f2ad7d8ba1677a90910e10cf33bb2430218fb

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
