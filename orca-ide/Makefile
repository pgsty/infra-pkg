# Preserve upstream Orca desktop packages, including their native metadata.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=orca-ide
VERSION=1.4.273
PROXY ?= http://127.0.0.1:8888

RPM_FILE_arm64=orca-ide-1.4.273.aarch64.rpm
RPM_URL_arm64=https://github.com/stablyai/orca/releases/download/v1.4.273/orca-ide-1.4.273.aarch64.rpm
SHA256_RPM_arm64=4441201c461f7090b8c3fc17a6c4e98c534ea41f3dd91aec9e35fbc20778513a
RPM_FILE_amd64=orca-ide-1.4.273.x86_64.rpm
RPM_URL_amd64=https://github.com/stablyai/orca/releases/download/v1.4.273/orca-ide-1.4.273.x86_64.rpm
SHA256_RPM_amd64=f8bdf59e1d22b178f52e556c1a82370e4f0b8aedf87e3daa6c32a3c43f1c9e9a
DEB_FILE_amd64=orca-ide_1.4.273_amd64.deb
DEB_URL_amd64=https://github.com/stablyai/orca/releases/download/v1.4.273/orca-ide_1.4.273_amd64.deb
SHA256_DEB_amd64=8e3a3497c208bc0d53c0cfc3ce6fef7f1cf659361246eee4d3da0ccf73eb4d15
DEB_FILE_arm64=orca-ide_1.4.273_arm64.deb
DEB_URL_arm64=https://github.com/stablyai/orca/releases/download/v1.4.273/orca-ide_1.4.273_arm64.deb
SHA256_DEB_arm64=94bbc410a7f28701b8b9e9281674c0418a4731a5cd7ad9629aca90088b4c866c

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:
.PHONY: default all one get link download verify build clean
