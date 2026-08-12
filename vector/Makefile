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
VERSION=0.57.0
RELEASE=1
PROXY ?= http://127.0.0.1:8118

DEB_FILE_amd64=vector_$(VERSION)-$(RELEASE)_amd64.deb
DEB_FILE_arm64=vector_$(VERSION)-$(RELEASE)_arm64.deb
RPM_FILE_amd64=vector-$(VERSION)-$(RELEASE).x86_64.rpm
RPM_FILE_arm64=vector-$(VERSION)-$(RELEASE).aarch64.rpm
DEB_URL_amd64=https://github.com/vectordotdev/vector/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/vectordotdev/vector/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/vectordotdev/vector/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/vectordotdev/vector/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=ee24ecf72292ce965b2fefc5439efa9281c75a982c4a90a2295e30561311e88e
SHA256_DEB_arm64=24bb9c86039c8019f896743aec3c1b97edbc135c66cdd23ddebef27bd648dbb7
SHA256_RPM_amd64=eee023de1db5de923f043e494f8f03ae6027a18fda4b7b44034ac680b820a28d
SHA256_RPM_arm64=4394b83f383c79261082ebfe2d5d646dc27f923a3a072a4c2cbb305d1675dc02

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
