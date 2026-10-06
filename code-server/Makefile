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
VERSION=4.140.0
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=code-server_4.140.0_amd64.deb
DEB_FILE_arm64=code-server_4.140.0_arm64.deb
RPM_FILE_amd64=code-server-4.140.0-amd64.rpm
RPM_FILE_arm64=code-server-4.140.0-arm64.rpm
DEB_URL_amd64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=281742720604c6654147186d54d1712f833ed7e41a734cc501ca00d4f20301aa
SHA256_DEB_arm64=455dece4da82a6f43f455879992d11769137114dbd340611fdea2299cf8566fd
SHA256_RPM_amd64=fad681aeef70b7a17280d79bb0f22b2f985aac8204af291608e7f762cb6c193d
SHA256_RPM_arm64=daabc9c85f464d208c9a1a6491087b4e715ae467ba6ba2b8655399466e94c2aa

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
