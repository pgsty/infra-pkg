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
VERSION=0.62.0
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
SHA256_DEB_amd64=b5398c254d06baa63aaa92b0bce1bc44040f0ccd7bdf3a4b472bb5511199bdf4
SHA256_DEB_arm64=4aa7dfa83dfbd66253b9c1ce15d100448681f7e29e65f8145d2112656e26c7bb
SHA256_RPM_amd64=d7290d8e594c0e1f6ee959f7442f31db017a9231869aa47365aa8ec8676cd4bc
SHA256_RPM_arm64=2806b7c19cb3751e6a4736c46e1fd249410c0a989e919c849cbd3f2a8b364aca

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
