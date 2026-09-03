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
VERSION=0.58.0
RELEASE=1
PROXY ?= http://127.0.0.1:8118

DEB_FILE_amd64=vector_$(VERSION)-$(RELEASE)_amd64.deb
DEB_FILE_arm64=vector_$(VERSION)-$(RELEASE)_arm64.deb
RPM_FILE_amd64=vector-$(VERSION)-$(RELEASE).x86_64.rpm
RPM_FILE_arm64=vector-$(VERSION)-$(RELEASE).aarch64.rpm
DEB_URL_amd64=https://github.com/vectordotdev/vector/releases/download/v$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://github.com/vectordotdev/vector/releases/download/v$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://github.com/vectordotdev/vector/releases/download/v$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://github.com/vectordotdev/vector/releases/download/v$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=bf9f6241ebf8e2dde3fa4e99d07e1daccf99f0c266b04608a4f0d1dd3a7e96cf
SHA256_DEB_arm64=a11f15f5463e492b7c4907db7ad2b44eb8f919309ea82772155327961c43a378
SHA256_RPM_amd64=7286cd7b08d4743d06710b8f8e11b25d42e7dc66d2d0c067376432e619234033
SHA256_RPM_arm64=297087fb38a5d5dde31354b2e220686691819a112e511ff9c4e1128ddc2a1cc2

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
