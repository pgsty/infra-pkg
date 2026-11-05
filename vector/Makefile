#==============================================================#
# File      :   Makefile
# Desc      :   Download official Vector DEB/RPM packages
# Path      :   vector/Makefile
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=vector
VERSION=0.61.0
RELEASE=1
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=vector_$(VERSION)-$(RELEASE)_amd64.deb
DEB_FILE_arm64=vector_$(VERSION)-$(RELEASE)_arm64.deb
RPM_FILE_amd64=vector-$(VERSION)-$(RELEASE).x86_64.rpm
RPM_FILE_arm64=vector-$(VERSION)-$(RELEASE).aarch64.rpm
DEB_URL_amd64=https://github.com/vectordotdev/vector/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/vectordotdev/vector/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/vectordotdev/vector/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/vectordotdev/vector/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=1cf2bc77f865e05e539c177feb0eb5feee20ee2762ea379f101610c9625fc4b8
SHA256_DEB_arm64=60cc8a938a2389ce7de4d2e7c0f025ff052eb18cfcfe47f69776570cfcab1456
SHA256_RPM_amd64=658deb9e3c8f245bffbdbc8b101abe7db03391074e6309226b7dd9806af8b98e
SHA256_RPM_arm64=1c01b0b1ae5c131c96439e59bae809516fe2ea1451c9571221274264390bc949

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
