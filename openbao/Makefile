#==============================================================#
# File      :   Makefile
# Desc      :   Download official OpenBao DEB/RPM packages
# Path      :   openbao/Makefile
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=openbao
VERSION=2.7.2
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=openbao_$(VERSION)_linux_amd64.deb
DEB_FILE_arm64=openbao_$(VERSION)_linux_arm64.deb
RPM_FILE_amd64=openbao_$(VERSION)_linux_amd64.rpm
RPM_FILE_arm64=openbao_$(VERSION)_linux_arm64.rpm
DEB_URL_amd64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=42bd0890a8e2060e5f29410ea828ee047aa2de21028045731a0516d5a532928c
SHA256_DEB_arm64=f9f40f906aaf673f536e59e45be3f485408b36cdb75697e89bb5201b8545dc46
SHA256_RPM_amd64=24cf378047cd759d0a8b4da645e694b2f6af320ef20ac5536ad91fa050d18d34
SHA256_RPM_arm64=251d6d49582d726452a531a90e8bc9f6f51f20b4b207fb9c80caf49c05da9f73

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
