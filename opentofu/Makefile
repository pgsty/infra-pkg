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
VERSION=1.13.2
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=tofu_$(VERSION)_amd64.deb
DEB_FILE_arm64=tofu_$(VERSION)_arm64.deb
RPM_FILE_amd64=tofu_$(VERSION)_amd64.rpm
RPM_FILE_arm64=tofu_$(VERSION)_arm64.rpm
DEB_URL_amd64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=4ac1080e445fe4e6af87895be485390de256e3657add0fdaca18e2c286424396
SHA256_DEB_arm64=5c32e7f1cbe265a1ed4b47de21701fa60cedcdba7306d32758683e2505253e86
SHA256_RPM_amd64=125619bf8aebc8e15131f73f543b4c9aa5f7c05ec3d2c9b31c45279391c31d24
SHA256_RPM_arm64=535e3290b99bbfccb3306aaf22aa288bc8b97a1efad66a7e7cc54480b83f3aa6

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
