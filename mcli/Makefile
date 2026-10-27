#==============================================================#
# File      :   Makefile
# Desc      :   Download official mcli DEB/RPM packages
# Path      :   mcli/Makefile
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=mcli
VERSION=20261026000000.0.0
TAG=RELEASE.2026-10-26T00-00-00Z
RELEASE=1
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=mcli_$(VERSION)_amd64.deb
DEB_FILE_arm64=mcli_$(VERSION)_arm64.deb
RPM_FILE_amd64=mcli-$(VERSION)-$(RELEASE).x86_64.rpm
RPM_FILE_arm64=mcli-$(VERSION)-$(RELEASE).aarch64.rpm
DEB_URL_amd64=https://github.com/pgsty/mc/releases/download/$(TAG)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/pgsty/mc/releases/download/$(TAG)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/pgsty/mc/releases/download/$(TAG)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/pgsty/mc/releases/download/$(TAG)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=801cd199d1aef6afaac3be3dc9012f9b399e388dbde28f0e52f68eef6c40834c
SHA256_DEB_arm64=b8ac31a2f5dac19486ba6155f8020fa9cd9255b603b3b4f3ea426d3b17e61ea2
SHA256_RPM_amd64=315dfaecb176f85d5c45f64a4476608cc95e17630934792af4d90fffc1e48df2
SHA256_RPM_arm64=43f268716fdbe7b96b5b3eef581811b1b9c31140b7dc26d336efffe565074fda

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
