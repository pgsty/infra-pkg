# Preserve upstream Orca desktop packages, including their native metadata.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=orca-ide
VERSION=1.4.267
PROXY ?= http://127.0.0.1:8888

RPM_FILE_arm64=orca-ide-1.4.267.aarch64.rpm
RPM_URL_arm64=https://github.com/stablyai/orca/releases/download/v1.4.267/orca-ide-1.4.267.aarch64.rpm
SHA256_RPM_arm64=1d791a6dd20dc3a9f8f113f265b1ebdab0a10439e37c0799f7627522ee2de501
RPM_FILE_amd64=orca-ide-1.4.267.x86_64.rpm
RPM_URL_amd64=https://github.com/stablyai/orca/releases/download/v1.4.267/orca-ide-1.4.267.x86_64.rpm
SHA256_RPM_amd64=f4332c82c5dff0a70f06536a918204969c8af7283f6d9a032d8d05f9eb20aa8f
DEB_FILE_amd64=orca-ide_1.4.267_amd64.deb
DEB_URL_amd64=https://github.com/stablyai/orca/releases/download/v1.4.267/orca-ide_1.4.267_amd64.deb
SHA256_DEB_amd64=7e7c455fe6fab97eaa3825103c104074a208afd598b66052c2a9dc5643efbcea
DEB_FILE_arm64=orca-ide_1.4.267_arm64.deb
DEB_URL_arm64=https://github.com/stablyai/orca/releases/download/v1.4.267/orca-ide_1.4.267_arm64.deb
SHA256_DEB_arm64=4cb4974ad6794905c76aa37e1a8d152af977a1661d251a6a29558bb6d4d4f160

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:
.PHONY: default all one get link download verify build clean
