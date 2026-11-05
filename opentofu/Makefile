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
VERSION=1.13.8
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=tofu_$(VERSION)_amd64.deb
DEB_FILE_arm64=tofu_$(VERSION)_arm64.deb
RPM_FILE_amd64=tofu_$(VERSION)_amd64.rpm
RPM_FILE_arm64=tofu_$(VERSION)_arm64.rpm
DEB_URL_amd64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=de3e77484cecd9c67494725cb4f9b1bb73c863462486d9a54f44efe49f2e5a63
SHA256_DEB_arm64=dafeb9848e5446cce2e6282b5c325e99c011263fbfaf80a0c941e19da269a515
SHA256_RPM_amd64=fb2633cce93ccc187f774a918cb50942c6dea0ab9fdf0d8856d6dc38be5b36b2
SHA256_RPM_arm64=fbdefd3235c1ebf14edd96e4152e5c5f6b080740068158d3c87e75e0678b604f

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
