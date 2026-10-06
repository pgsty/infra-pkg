#==============================================================#
# File      :   Makefile
# Desc      :   Download official Grafana OSS DEB/RPM packages
# Path      :   grafana/Makefile
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=grafana
VERSION=13.2.3
BUILD=36482603486
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=grafana_$(VERSION)_$(BUILD)_linux_amd64.deb
DEB_FILE_arm64=grafana_$(VERSION)_$(BUILD)_linux_arm64.deb
RPM_FILE_amd64=grafana_$(VERSION)_$(BUILD)_linux_amd64.rpm
RPM_FILE_arm64=grafana_$(VERSION)_$(BUILD)_linux_arm64.rpm
DEB_URL_amd64=https://dl.grafana.com/grafana/release/$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://dl.grafana.com/grafana/release/$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://dl.grafana.com/grafana/release/$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://dl.grafana.com/grafana/release/$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=55ec511999f9c56f3c26b633d0dc31b750c77a682a5ef379edf0d3fe634a7a2f
SHA256_DEB_arm64=c7d1247182e6da5ffed2ffe6c07382d354ec65be2161724aa37c147f430167b7
SHA256_RPM_amd64=4fc2adc0912421b630696423d5c05ee2df560347fdb5e906a927fffc3201d066
SHA256_RPM_arm64=bc4d1750b8ded97caa8ca688a65644b68ba468292d9953aebdcb816aa2f0a817

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
