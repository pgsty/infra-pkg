#==============================================================#
# File      :   Makefile
# Desc      :   Download official OpenTofu DEB/RPM packages
# Path      :   opentofu/Makefile
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=opentofu
VERSION=1.13.1
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=tofu_$(VERSION)_amd64.deb
DEB_FILE_arm64=tofu_$(VERSION)_arm64.deb
RPM_FILE_amd64=tofu_$(VERSION)_amd64.rpm
RPM_FILE_arm64=tofu_$(VERSION)_arm64.rpm
DEB_URL_amd64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/opentofu/opentofu/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=1cc324c6193dbc0fad98548eb8f6829a96416493425ca46bc70a291290780b32
SHA256_DEB_arm64=e207e82f7e04b0b8fabb78e8b18ebc7d292ddfe50065f98024259e1285703358
SHA256_RPM_amd64=299e7ff3cff78e640d77c1af8a5e1d22a9e876678e2d2baaf0f7ac4a4f0e36e9
SHA256_RPM_arm64=0f4b299ad97d203b618a38550c9db61afc420d1ff41259d50a425e3b4eb8eb78

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
