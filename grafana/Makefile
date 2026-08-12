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
VERSION=13.1.3
BUILD=31135815010
PROXY ?= http://127.0.0.1:8118

DEB_FILE_amd64=grafana_$(VERSION)_$(BUILD)_linux_amd64.deb
DEB_FILE_arm64=grafana_$(VERSION)_$(BUILD)_linux_arm64.deb
RPM_FILE_amd64=grafana_$(VERSION)_$(BUILD)_linux_amd64.rpm
RPM_FILE_arm64=grafana_$(VERSION)_$(BUILD)_linux_arm64.rpm
DEB_URL_amd64=https://dl.grafana.com/grafana/release/$(VERSION)/$(DEB_FILE_amd64)
DEB_URL_arm64=https://dl.grafana.com/grafana/release/$(VERSION)/$(DEB_FILE_arm64)
RPM_URL_amd64=https://dl.grafana.com/grafana/release/$(VERSION)/$(RPM_FILE_amd64)
RPM_URL_arm64=https://dl.grafana.com/grafana/release/$(VERSION)/$(RPM_FILE_arm64)
SHA256_DEB_amd64=5969987920b0c3846f846c2a53f8ce8fa35453f8a15bd88e1dc3aeef5e931db3
SHA256_DEB_arm64=5b0c3073bfab8c67a7e19d53a3727fc41d2557fbc737665607168ac010023df7
SHA256_RPM_amd64=d05506c675109ab865c5f170df74bca54216283406dcc2d58d2b7f6389df2a12
SHA256_RPM_arm64=5b0632ab1249e367c7096e5b2f823a6e7b519c20ebda1848b1d6f1b93805d93d

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
