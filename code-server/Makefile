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
VERSION=4.143.1
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=code-server_4.143.1_amd64.deb
DEB_FILE_arm64=code-server_4.143.1_arm64.deb
RPM_FILE_amd64=code-server-4.143.1-amd64.rpm
RPM_FILE_arm64=code-server-4.143.1-arm64.rpm
DEB_URL_amd64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=e4b771c98fafbe2af3990ecd71d93ba22515588db550007076768a014ae34c02
SHA256_DEB_arm64=79ca8df2db219b24de75e2a830c5302808124d8c2bf132f4bc6105cea834bb1c
SHA256_RPM_amd64=7cf56a3bb6a9ef6238d9b2c8f0f6e022180fcd782dd4ff0f5b5055b86c05139d
SHA256_RPM_arm64=067a1c18f3ed635284cd19d4ae1ef9a8414b992957f9d413edde141729caa540

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
