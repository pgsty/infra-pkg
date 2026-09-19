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
VERSION=4.137.0
PROXY ?= http://127.0.0.1:8118

DEB_FILE_amd64=code-server_4.137.0_amd64.deb
DEB_FILE_arm64=code-server_4.137.0_arm64.deb
RPM_FILE_amd64=code-server-4.137.0-amd64.rpm
RPM_FILE_arm64=code-server-4.137.0-arm64.rpm
DEB_URL_amd64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=f0165952d918092eb321a2d4e75a1e7035807d687b698ccda63aea2bfa1c58bc
SHA256_DEB_arm64=0d2b58387833f328bec3723f842bf68e59031fc24b1e03a9c6c1659765a420ef
SHA256_RPM_amd64=2eed43d75346e93987f7c96fb0a994948f1722b765008cf2fc989c84a19dfcd0
SHA256_RPM_arm64=4d7b446a230b949a91116e546b5ee5f83a515276ab3accbfa23a7a24fd956300

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
