#==============================================================#
# File      :   Makefile
# Desc      :   Download official Vector DEB/RPM packages
# Path      :   vector/Makefile
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=vector
VERSION=0.59.0
RELEASE=1
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=vector_$(VERSION)-$(RELEASE)_amd64.deb
DEB_FILE_arm64=vector_$(VERSION)-$(RELEASE)_arm64.deb
RPM_FILE_amd64=vector-$(VERSION)-$(RELEASE).x86_64.rpm
RPM_FILE_arm64=vector-$(VERSION)-$(RELEASE).aarch64.rpm
DEB_URL_amd64=https://github.com/vectordotdev/vector/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/vectordotdev/vector/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/vectordotdev/vector/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/vectordotdev/vector/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=1dd9f52bda25d2364ab04d496a3b7edbc775b1a3cd02d9985eb81f3c174a245f
SHA256_DEB_arm64=5779afdc9abf08373c09b6656c933c8e1da34926c9b646cd80e76d96d7d64133
SHA256_RPM_amd64=133225386e4401800dcdef0ce4d600510cf4780bddc2fd7b8f34c8f66411fee4
SHA256_RPM_arm64=436fdef32e58041b306982ccec834fd4135dc3920b2aaa2e12686386f1f23088

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
