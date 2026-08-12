#==============================================================#
# File      :   Makefile
# Desc      :   Download official code-server DEB/RPM packages
# Path      :   code-server/Makefile
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=code-server
VERSION=4.132.0
PROXY ?= http://127.0.0.1:8118

DEB_FILE_amd64=code-server_4.132.0_amd64.deb
DEB_FILE_arm64=code-server_4.132.0_arm64.deb
RPM_FILE_amd64=code-server-4.132.0-amd64.rpm
RPM_FILE_arm64=code-server-4.132.0-arm64.rpm
DEB_URL_amd64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=18e0e69920ab23b725cb219fb42bc045a908421448cf496a3124314e1a02bcf1
SHA256_DEB_arm64=a7f76980a44bce06490db5fb8ee50b2b94674b3940f04899c818b3ef4058cfc2
SHA256_RPM_amd64=d2b1aa1c96b85be73a992bccade230c1864af7b43fe6f4245ad4ffc33ffe7f1d
SHA256_RPM_arm64=feaaf7af05b1675a18fc86fff1208e0c5d3288db4e44d664aa218adcb726051e

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
