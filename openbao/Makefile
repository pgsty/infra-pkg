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
VERSION=2.7.0
PROXY ?= http://127.0.0.1:8118

DEB_FILE_amd64=openbao_$(VERSION)_linux_amd64.deb
DEB_FILE_arm64=openbao_$(VERSION)_linux_arm64.deb
RPM_FILE_amd64=openbao_$(VERSION)_linux_amd64.rpm
RPM_FILE_arm64=openbao_$(VERSION)_linux_arm64.rpm
DEB_URL_amd64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=7412233fef6bbe0e5093aa5461f493dd3a0f6193c8d5a5ba3a7ff475f96f34a2
SHA256_DEB_arm64=f84eb46770ae252c4d8f43dc8546d044151d58bd3b79eae71f9f7516ef29c75d
SHA256_RPM_amd64=6619ff70295d18716139d54d5fe517c4bb87d6075d400c816fbdbf921fa92612
SHA256_RPM_arm64=50ee72a5b7b38b99ddef78d58882611fc2ac8fefcc62a154ea1552daac8b2cce

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
