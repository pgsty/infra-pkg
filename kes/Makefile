#==============================================================#
# File      :   Makefile
# Desc      :   Download official KES DEB/RPM packages
# Path      :   kes/Makefile
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=kes
VERSION=20261018000000.0.0
TAG=RELEASE.2026-10-18T00-00-00Z
RELEASE=1
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=kes_$(VERSION)_amd64.deb
DEB_FILE_arm64=kes_$(VERSION)_arm64.deb
RPM_FILE_amd64=kes-$(VERSION)-$(RELEASE).x86_64.rpm
RPM_FILE_arm64=kes-$(VERSION)-$(RELEASE).aarch64.rpm
DEB_URL_amd64=https://github.com/pgsty/kes/releases/download/$(TAG)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/pgsty/kes/releases/download/$(TAG)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/pgsty/kes/releases/download/$(TAG)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/pgsty/kes/releases/download/$(TAG)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=6a9eb5ad74d976aaa77ddfc95c2fd6174a31ecbbdcb8ba5228d602646ffe99bd
SHA256_DEB_arm64=5a7ccd2d38453b524ad575ea6a19a305af67a1e98718051d3757904d823457b2
SHA256_RPM_amd64=317ccdcb785a386fb8c81ec673640979216dc8fa411cc5c2dc37e9a582a26864
SHA256_RPM_arm64=7587851fc3bd615fa87d660a2379fd6279fa10c2a4ad541a8bf3cbe2a2d5f9e7

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
