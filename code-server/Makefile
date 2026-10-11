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
VERSION=4.141.0
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=code-server_4.141.0_amd64.deb
DEB_FILE_arm64=code-server_4.141.0_arm64.deb
RPM_FILE_amd64=code-server-4.141.0-amd64.rpm
RPM_FILE_arm64=code-server-4.141.0-arm64.rpm
DEB_URL_amd64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/coder/code-server/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=f384beb4f3ba207e0bca27d0dbd36dd825d5aa909d78c6d4baa8703eaf6b77ba
SHA256_DEB_arm64=0bca33a9b01180ad88f0b8969a8e34ae1c76417df471697e7cd65c20ef5dd60d
SHA256_RPM_amd64=d0f4c56888795abfe92f3e058f555b43fd9f3c65b4397394e09c12303b0360aa
SHA256_RPM_arm64=b2d597808b89bdca19f730157eba3ea7279258ffbb0426f860a98f27d427f872

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
