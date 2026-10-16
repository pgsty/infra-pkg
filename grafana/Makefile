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
VERSION=13.2.4
BUILD=38252365904
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=grafana_$(VERSION)_$(BUILD)_linux_amd64.deb
DEB_FILE_arm64=grafana_$(VERSION)_$(BUILD)_linux_arm64.deb
RPM_FILE_amd64=grafana_$(VERSION)_$(BUILD)_linux_amd64.rpm
RPM_FILE_arm64=grafana_$(VERSION)_$(BUILD)_linux_arm64.rpm
DEB_URL_amd64=https://dl.grafana.com/grafana/release/$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://dl.grafana.com/grafana/release/$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://dl.grafana.com/grafana/release/$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://dl.grafana.com/grafana/release/$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=f32ba4e166e35a376f39cbeb8dd47c57f7bf608b09339cb41adf6d39082af3c5
SHA256_DEB_arm64=66ff1bcbb830e10e5a776ecadf3264941fe6d9b51ce10a3a07b73fe7517679f8
SHA256_RPM_amd64=161d015a6635f2a58e2d4fc597a48ba9b3935abd81511679dd1657db0f6a4a26
SHA256_RPM_arm64=1c100c89dc2631a405b9763a88ec3ee8bb223a6f81fa62de5e85c4cdc185983b

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
