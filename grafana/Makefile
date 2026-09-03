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
VERSION=13.2.0
BUILD=32077357341
PROXY ?= http://127.0.0.1:8118

DEB_FILE_amd64=grafana_$(VERSION)_$(BUILD)_linux_amd64.deb
DEB_FILE_arm64=grafana_$(VERSION)_$(BUILD)_linux_arm64.deb
RPM_FILE_amd64=grafana_$(VERSION)_$(BUILD)_linux_amd64.rpm
RPM_FILE_arm64=grafana_$(VERSION)_$(BUILD)_linux_arm64.rpm
DEB_URL_amd64=https://dl.grafana.com/grafana/release/$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://dl.grafana.com/grafana/release/$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://dl.grafana.com/grafana/release/$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://dl.grafana.com/grafana/release/$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=2da4a1b6d77ab850cd1573dabdd371e73c019faeb5505022ccb193720ad41615
SHA256_DEB_arm64=40d63f16f202dc77c5c4772eb77642b1bda39b07f3ee26ff822127092aab71e9
SHA256_RPM_amd64=1292c01c625f10c6fad2bba58b86ce962f94934c98a735d107b4349a86506436
SHA256_RPM_arm64=f831208c47ecd6fa30bd1a983ef28e30e2349b194d3c026eec90787814f303ed

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
