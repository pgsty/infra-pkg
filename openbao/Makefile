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
VERSION=2.6.2
PROXY ?= http://127.0.0.1:8118

DEB_FILE_amd64=openbao_$(VERSION)_linux_amd64.deb
DEB_FILE_arm64=openbao_$(VERSION)_linux_arm64.deb
RPM_FILE_amd64=openbao_$(VERSION)_linux_amd64.rpm
RPM_FILE_arm64=openbao_$(VERSION)_linux_arm64.rpm
DEB_URL_amd64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=f22b703e626d03d1595c21cf1c57c8737675b721daa3b8e3972531ceafcc3993
SHA256_DEB_arm64=554e0f196394edc5b35267dc8888e28eaf0f3a7de01271f232c5d93e709b6cf8
SHA256_RPM_amd64=586262fc6e49324efeee7969798a75f72402f30ba9edc2966f73c2dcc60aa48c
SHA256_RPM_arm64=1bedfbe3a24925c0e037564ea4504a8890aff7924fb72d6d699118d3cf8d61b5

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
