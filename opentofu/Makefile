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
VERSION=1.13.9
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=tofu_$(VERSION)_amd64.deb
DEB_FILE_arm64=tofu_$(VERSION)_arm64.deb
RPM_FILE_amd64=tofu_$(VERSION)_amd64.rpm
RPM_FILE_arm64=tofu_$(VERSION)_arm64.rpm
DEB_URL_amd64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=dcc51f35f3a909e5daa616059c61b3ef1c157e54a2786d457ab6ef19d03a6dfb
SHA256_DEB_arm64=bf77bc8cdada8dec9ce3dc0af16c5ab891a8c03068cd74493ca105c72f8c78d5
SHA256_RPM_amd64=b61bb46f7bf77c8b8279d757eee83e35d4b11ebc57049129a68bfc1387251321
SHA256_RPM_arm64=23b9cf63c935c47eaa398a924f530950236f6772bb9686772e5e83e79e814b2c

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
