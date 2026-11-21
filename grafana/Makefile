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
VERSION=13.3.1
BUILD=42849527790
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=grafana_13.3.1_42849527790_linux_amd64.deb
DEB_FILE_arm64=grafana_13.3.1_42849527790_linux_arm64.deb
RPM_FILE_amd64=grafana_13.3.1_42849527790_linux_amd64.rpm
RPM_FILE_arm64=grafana_13.3.1_42849527790_linux_arm64.rpm
DEB_URL_amd64=https://dl.grafana.com/grafana/release/13.3.1/grafana_13.3.1_42849527790_linux_amd64.deb
DEB_URL_arm64=https://dl.grafana.com/grafana/release/13.3.1/grafana_13.3.1_42849527790_linux_arm64.deb
RPM_URL_amd64=https://dl.grafana.com/grafana/release/13.3.1/grafana_13.3.1_42849527790_linux_amd64.rpm
RPM_URL_arm64=https://dl.grafana.com/grafana/release/13.3.1/grafana_13.3.1_42849527790_linux_arm64.rpm
SHA256_DEB_amd64=397eec6e64a538c68231b9a55f09fc4504869f198fd5339032fa6fb98b77a952
SHA256_DEB_arm64=6b27669256c622014cb413dd26bc53d2a669948427aacc3d22e675b354056ae7
SHA256_RPM_amd64=ea438041cbab09308416fd2156d8affd224b2c8999360545b39210efd1dee4f7
SHA256_RPM_arm64=05ab0727686e44522d10f604f534b64a85ebf834cd7d6246ac016c6b1cefd1e1

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
