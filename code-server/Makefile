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
VERSION=4.144.0
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=code-server_4.144.0_amd64.deb
DEB_FILE_arm64=code-server_4.144.0_arm64.deb
RPM_FILE_amd64=code-server-4.144.0-amd64.rpm
RPM_FILE_arm64=code-server-4.144.0-arm64.rpm
DEB_URL_amd64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=45f5533b502edac68b7eb09c5cec44fd281f80264af9a87fde0bfb2c5e190615
SHA256_DEB_arm64=6baef72b340da08e76e5cf1e9504f657d00e80c8776bdaf86e97c30a80cd48e8
SHA256_RPM_amd64=703e59b498ff2dad7b037bbe134e87d2028c91f09ced719bfb98e0bb18536788
SHA256_RPM_arm64=8675b91cf8bbba29d81fa4a7cbd3dcfce2d4a5416a1be38edcbebb63a5c9dbfe

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
