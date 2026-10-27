#==============================================================#
# File      :   Makefile
# Desc      :   Download official Silo DEB/RPM packages
# Path      :   silo/Makefile
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=silo
VERSION=20261026000000.0.0
TAG=RELEASE.2026-10-26T00-00-00Z
RELEASE=1PGSTY
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=silo_$(VERSION)-$(RELEASE)_amd64.deb
DEB_FILE_arm64=silo_$(VERSION)-$(RELEASE)_arm64.deb
RPM_FILE_amd64=silo-$(VERSION)-$(RELEASE).x86_64.rpm
RPM_FILE_arm64=silo-$(VERSION)-$(RELEASE).aarch64.rpm
DEB_URL_amd64=https://github.com/pgsty/silo/releases/download/$(TAG)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/pgsty/silo/releases/download/$(TAG)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/pgsty/silo/releases/download/$(TAG)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/pgsty/silo/releases/download/$(TAG)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=317d105e5ff1b757094cc11cc00063ec95c7dc824455f4150a7174f3242bb9aa
SHA256_DEB_arm64=e8b317e5abe2bb51f2b4c01ad7c23dbcb6a0199803bc7fe3e6861c6766d838f8
SHA256_RPM_amd64=f26cfcab188bf458e9d0905ef326b68c2864ce8c1a9e2539e0fe0485c0beb922
SHA256_RPM_arm64=5335cdd5e7a09b10a6e3a4ad6d9f31e05ebc49f937874b9c889e807a423d54f5

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
