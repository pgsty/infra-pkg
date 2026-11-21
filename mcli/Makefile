#==============================================================#
# File      :   Makefile
# Desc      :   Download official mcli DEB/RPM packages
# Path      :   mcli/Makefile
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=mcli
VERSION=20261112000000.0.0
TAG=RELEASE.2026-11-12T00-00-00Z
RELEASE=1
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=mcli_20261112000000.0.0_amd64.deb
DEB_FILE_arm64=mcli_20261112000000.0.0_arm64.deb
RPM_FILE_amd64=mcli-20261112000000.0.0-1.x86_64.rpm
RPM_FILE_arm64=mcli-20261112000000.0.0-1.aarch64.rpm
DEB_URL_amd64=https://github.com/pgsty/mc/releases/download/RELEASE.2026-11-12T00-00-00Z/mcli_20261112000000.0.0_amd64.deb
DEB_URL_arm64=https://github.com/pgsty/mc/releases/download/RELEASE.2026-11-12T00-00-00Z/mcli_20261112000000.0.0_arm64.deb
RPM_URL_amd64=https://github.com/pgsty/mc/releases/download/RELEASE.2026-11-12T00-00-00Z/mcli-20261112000000.0.0-1.x86_64.rpm
RPM_URL_arm64=https://github.com/pgsty/mc/releases/download/RELEASE.2026-11-12T00-00-00Z/mcli-20261112000000.0.0-1.aarch64.rpm
SHA256_DEB_amd64=28663f8d54d2b01b451053b2e851b8775a91bd1e2c2a3bcc9ce5d1a45c494d82
SHA256_DEB_arm64=2d03974597d05da274ca47cd8a42f2c2375e2f46f66a265150cb5faf4f603ef8
SHA256_RPM_amd64=696959adc4ee4d92f4cf358a055754a566b972c29dfe89164891b8422892442a
SHA256_RPM_arm64=9b4a7593de4df9765464c8ca64c01c75dbd2f4287b055f05ff10f9d2763dadd6

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
