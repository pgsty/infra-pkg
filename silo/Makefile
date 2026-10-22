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
VERSION=20261018000000.0.0
TAG=RELEASE.2026-10-18T00-00-00Z
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
SHA256_DEB_amd64=cbda836b96598e58013492b4d2c272fd88e0253654b059a84ec89827237a71b9
SHA256_DEB_arm64=cbb2d2ed9c376c6ed17f12037c5a361303fe4c511335358f95664291ca0460b5
SHA256_RPM_amd64=42efa96f113fcc9051af8d49b2d4e97ada42cc6c27ba47297a392805c91e3572
SHA256_RPM_arm64=34283e44cb76181474744f4f8e4d6b194ddbc5315d5a5bb6f64c83b41742974e

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
