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
VERSION=2.7.1
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=openbao_$(VERSION)_linux_amd64.deb
DEB_FILE_arm64=openbao_$(VERSION)_linux_arm64.deb
RPM_FILE_amd64=openbao_$(VERSION)_linux_amd64.rpm
RPM_FILE_arm64=openbao_$(VERSION)_linux_arm64.rpm
DEB_URL_amd64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/openbao/openbao/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=aa5dd78f590a89256dffae7c7f8664b11e4380478da86454d8030020f6af0add
SHA256_DEB_arm64=b46dfc7e72b9e1f7fea68713748ca170c3ea9b4946fd2142d9a6c3323b4b85b1
SHA256_RPM_amd64=698970b7e58590bd0ceb55043ce6f5e5d53e67b4a825e296cc197b21d6a6d700
SHA256_RPM_arm64=3ea0d10a9a44a2cda37d43ad6d1adf80dd4a1c72a1fe0de890b07d0af5354a34

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
