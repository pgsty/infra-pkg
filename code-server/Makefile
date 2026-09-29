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
VERSION=4.139.1
PROXY ?= http://127.0.0.1:8118

DEB_FILE_amd64=code-server_4.139.1_amd64.deb
DEB_FILE_arm64=code-server_4.139.1_arm64.deb
RPM_FILE_amd64=code-server-4.139.1-amd64.rpm
RPM_FILE_arm64=code-server-4.139.1-arm64.rpm
DEB_URL_amd64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=9f841557bfb5926eadce253a6c899b064cc9919f91cafb7b676245919d1a68a3
SHA256_DEB_arm64=05dc61157214a7bc4ca2106e66e7a6314244c6cb743471ba87e4233c0c80888a
SHA256_RPM_amd64=e0153c46676e0fc8d789a362b7e64508f99001f63c35521789d0d063ef5d933d
SHA256_RPM_arm64=34e38458bfad5dd68dce20aa3b5d7b89dd9632ac516e109c21fa0ebbb5fca95e

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
