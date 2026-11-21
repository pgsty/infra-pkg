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
VERSION=2.7.3
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=openbao_$(VERSION)_linux_amd64.deb
DEB_FILE_arm64=openbao_$(VERSION)_linux_arm64.deb
RPM_FILE_amd64=openbao_$(VERSION)_linux_amd64.rpm
RPM_FILE_arm64=openbao_$(VERSION)_linux_arm64.rpm
DEB_URL_amd64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=0800c71469c1d7a5d5c9fb37ce0e441cad97d9fe122dab70391c8371e290b935
SHA256_DEB_arm64=5b9f980245e083a6eaf88e7fce1e7d77a75bb1befd2b824e550fe6edd3e28d27
SHA256_RPM_amd64=8b050f9ae9b1893e556a2e935adf2fc5f2fbfab340b8d8810c1b0765d5fde997
SHA256_RPM_arm64=0de6120f338a4f5f2191cb525dbd59b408834fdee384edb67cc7511a9f5deb94

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
