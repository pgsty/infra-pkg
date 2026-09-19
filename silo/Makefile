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
VERSION=20260916000000.0.0
TAG=RELEASE.2026-09-16T00-00-00Z
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
SHA256_DEB_amd64=176aad3944d9e9f949baf47bcea86e62a3271094be075c6547c056f652ae7e5f
SHA256_DEB_arm64=32f7fab06f38a90920bf7295017b031da0eb03fcb1e54fd948f109fd30e3a711
SHA256_RPM_amd64=cb4d6690d386e43dca0b9c6ae4e3abb1fad49c75f9df7d36502c5f8742ef3a77
SHA256_RPM_arm64=e7fa4c2fcf49a9d7632e91b4aceef3225c5330571cb19116e5ba59c8d2dc031c

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
