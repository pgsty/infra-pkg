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
VERSION=20260806000000.0.0
TAG=RELEASE.2026-08-06T00-00-00Z
RELEASE=1PGSTY
PROXY ?= http://127.0.0.1:8118

DEB_FILE_amd64=silo_$(VERSION)-$(RELEASE)_amd64.deb
DEB_FILE_arm64=silo_$(VERSION)-$(RELEASE)_arm64.deb
RPM_FILE_amd64=silo-$(VERSION)-$(RELEASE).x86_64.rpm
RPM_FILE_arm64=silo-$(VERSION)-$(RELEASE).aarch64.rpm
DEB_URL_amd64=https://github.com/pgsty/silo/releases/download/$(TAG)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/pgsty/silo/releases/download/$(TAG)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/pgsty/silo/releases/download/$(TAG)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/pgsty/silo/releases/download/$(TAG)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=aaa3d3d6090115beb093c150c165ae3ec44c199d359093cdf28de3a8f113a6fd
SHA256_DEB_arm64=e42214949b9a2b2ee30b6cb1012b60d8365a247a4ba4e81906053cac77fc3565
SHA256_RPM_amd64=da6e9c4ce3548bff3d2fd8c812657fd51e1533c8d0f9a6646816ab889abcdebf
SHA256_RPM_arm64=4ec6b47b4b6e4f724ea2b1881b742ab0b469f81e70d6da5e353a7d2f1e0eeefd

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
