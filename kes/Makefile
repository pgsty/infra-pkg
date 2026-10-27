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
VERSION=20261026000000.0.0
TAG=RELEASE.2026-10-26T00-00-00Z
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
SHA256_DEB_amd64=e48f4f2cd02946b33fa72a347defcd0923952bc2482efd0bc555c4d903b8f31c
SHA256_DEB_arm64=2a867585a7e7e08c0a19f535042e7380b19ec7daee9ad9b8ab68dcd315292cb4
SHA256_RPM_amd64=c62e5a75a28b8e0af6a02f250e0fb097b769453f3946caf0f23546fcc4a9a30b
SHA256_RPM_arm64=6625cc53b216c68f228364e6e21324872501dccfe029dae6c2a5ff067a1dc135

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
