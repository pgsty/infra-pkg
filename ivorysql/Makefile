# Preserve upstream ivorysql native packages without repacking.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
REPONAME=IvorySQL/IvorySQL
PACKAGE=ivorysql
VERSION=5.6
PROXY ?= http://127.0.0.1:8888

RPM_FILE_arm64=IvorySQL-5.6-74c405c-20261016.aarch64.rpm
RPM_URL_arm64=https://github.com/IvorySQL/IvorySQL/releases/download/IvorySQL_5.6/IvorySQL-5.6-74c405c-20261016.aarch64.rpm
SHA256_RPM_arm64=71dd2ef8203d0bede0c699d8b4fd06d8f05f0d5fa6ac87f81ca55d4ec74c2399
DEB_FILE_amd64=IvorySQL-5.6-74c405c-20261016.amd64.deb
DEB_URL_amd64=https://github.com/IvorySQL/IvorySQL/releases/download/IvorySQL_5.6/IvorySQL-5.6-74c405c-20261016.amd64.deb
SHA256_DEB_amd64=b11dd376545334a35ccfbbf59c31dac762f838d72090a420791ad16a21d73541
DEB_FILE_arm64=IvorySQL-5.6-74c405c-20261016.arm64.deb
DEB_URL_arm64=https://github.com/IvorySQL/IvorySQL/releases/download/IvorySQL_5.6/IvorySQL-5.6-74c405c-20261016.arm64.deb
SHA256_DEB_arm64=ee01bcb1524cc3bb0ede8bad3b00182182544dfc9aff26e6e8590a2fd9210435
RPM_FILE_amd64=IvorySQL-5.6-74c405c-20261016.x86_64.rpm
RPM_URL_amd64=https://github.com/IvorySQL/IvorySQL/releases/download/IvorySQL_5.6/IvorySQL-5.6-74c405c-20261016.x86_64.rpm
SHA256_RPM_amd64=e77aa62b5441424ae57311bd80a65ced124fb1370853623321ded170a6c8fe4d

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:
.PHONY: default all one get link download verify build verify-dist clean
