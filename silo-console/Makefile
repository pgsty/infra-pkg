# Download the upstream SILO Console native DEB/RPM packages without repacking.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
REPONAME=pgsty/silo-console
PACKAGE=silo-console
VERSION=2.6.0
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=silo-console_$(VERSION)_linux_amd64.deb
DEB_FILE_arm64=silo-console_$(VERSION)_linux_arm64.deb
RPM_FILE_amd64=silo-console_$(VERSION)_linux_amd64.rpm
RPM_FILE_arm64=silo-console_$(VERSION)_linux_arm64.rpm
DEB_URL_amd64=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=d73019f2eb218a928300013ec5df808080e2f63483c27116b783e91fe9b73211
SHA256_DEB_arm64=e76fa234fbe638fa37a57e54765e7aec9c52334bcd421ff2b3b44a24443f6de6
SHA256_RPM_amd64=e16fdd1e2d06daf2389d8b8fac6d48ac1dddad33314b399497d7c6d3ba7d1d4f
SHA256_RPM_arm64=ea27b0e707b567b84b2c96749f7a706c4c77a7d6a4527ad96841c1be3cbcb233

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
