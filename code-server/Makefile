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
VERSION=4.145.0
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=code-server_4.145.0_amd64.deb
DEB_FILE_arm64=code-server_4.145.0_arm64.deb
RPM_FILE_amd64=code-server-4.145.0-amd64.rpm
RPM_FILE_arm64=code-server-4.145.0-arm64.rpm
DEB_URL_amd64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=43fa1dc0e7929753bb3442e4ef40d4beb8bb5f8fe63601ede31b305536e6275b
SHA256_DEB_arm64=43813b81df484b49facf19d99faaa51683a2cdd8c652dc97ebddefa9cbe7fd6a
SHA256_RPM_amd64=51e7e4378b7c027ffe4468a03090fc6c1b89e3f42c34cc62d21e4b96e75150f1
SHA256_RPM_arm64=5021124dac0b03ab98f643929f8fd3e7233f140f649e2a8c707b127bcff3e753

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
