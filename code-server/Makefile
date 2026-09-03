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
VERSION=4.135.0
PROXY ?= http://127.0.0.1:8118

DEB_FILE_amd64=code-server_4.135.0_amd64.deb
DEB_FILE_arm64=code-server_4.135.0_arm64.deb
RPM_FILE_amd64=code-server-4.135.0-amd64.rpm
RPM_FILE_arm64=code-server-4.135.0-arm64.rpm
DEB_URL_amd64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=f87d0d49c6c0a59d41214c9510f506e4123991f2d27b41f6d56f3f5c96458d3e
SHA256_DEB_arm64=565e77cf74820d1cc3f473a17f41adb0703bbb07dc1243ded66a4740c595fdad
SHA256_RPM_amd64=270e4efbe4f56d52d8c9d80f6f45adedc5b67cfb549b0c0b94574babee1c8d43
SHA256_RPM_arm64=bc127957432997a459ac2bfebb37e985cbb13c111837da0466c5a371efae0952

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
