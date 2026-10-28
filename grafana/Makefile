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
VERSION=13.3.0
BUILD=40412481033
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=grafana_$(VERSION)_$(BUILD)_linux_amd64.deb
DEB_FILE_arm64=grafana_$(VERSION)_$(BUILD)_linux_arm64.deb
RPM_FILE_amd64=grafana_$(VERSION)_$(BUILD)_linux_amd64.rpm
RPM_FILE_arm64=grafana_$(VERSION)_$(BUILD)_linux_arm64.rpm
DEB_URL_amd64=https://dl.grafana.com/grafana/release/$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://dl.grafana.com/grafana/release/$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://dl.grafana.com/grafana/release/$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://dl.grafana.com/grafana/release/$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=458cb47824fda2c1e93c51e5d9c4893543f7fe24c58c2f5cb9c7a91d7360070f
SHA256_DEB_arm64=6e687b1e4d8a3545035a030a4e7e0bc632ffdb483f1487f912fb0b3673853c30
SHA256_RPM_amd64=b90daf6108231fba80cec2001b9a0759d4212bb50c4e315edddb4188c239a663
SHA256_RPM_arm64=086e5a3f00f37f88f0ded594e50311b861ce92161ead20a5bf5754940d3f53ff

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
