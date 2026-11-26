#==============================================================#
# File      :   Makefile
# Desc      :   Download official OpenTofu DEB/RPM packages
# Path      :   opentofu/Makefile
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=opentofu
VERSION=1.13.10
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=tofu_$(VERSION)_amd64.deb
DEB_FILE_arm64=tofu_$(VERSION)_arm64.deb
RPM_FILE_amd64=tofu_$(VERSION)_amd64.rpm
RPM_FILE_arm64=tofu_$(VERSION)_arm64.rpm
DEB_URL_amd64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=7388eba23a42216eb43baf9dcfdb9c2029ecfe644f5395b13e76beb6546980fd
SHA256_DEB_arm64=66990a825695091571102b53cc490b283f71afc7c06589630ea0866af241b685
SHA256_RPM_amd64=f2934362d035aebde48f654419c7b8e4f876587c297af999f2f0690d5963c87f
SHA256_RPM_arm64=4b4cc0c7e5c00575bc0d343cd91e54c34508fa89d3da52da977c607f529b6656

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
