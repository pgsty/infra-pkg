# Preserve upstream Orca desktop packages, including their native metadata.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=orca-ide
VERSION=1.4.271
PROXY ?= http://127.0.0.1:8888

RPM_FILE_arm64=orca-ide-1.4.271.aarch64.rpm
RPM_URL_arm64=https://github.com/stablyai/orca/releases/download/v1.4.271/orca-ide-1.4.271.aarch64.rpm
SHA256_RPM_arm64=0f64962649bf5fdf6da764cf9d871d1d42298efae3ad596e52843f7488a41e8c
RPM_FILE_amd64=orca-ide-1.4.271.x86_64.rpm
RPM_URL_amd64=https://github.com/stablyai/orca/releases/download/v1.4.271/orca-ide-1.4.271.x86_64.rpm
SHA256_RPM_amd64=a0cab5c749d6557ee00f59dfbae4d30fcb5a4a27e68c76865638d0304fa253ec
DEB_FILE_amd64=orca-ide_1.4.271_amd64.deb
DEB_URL_amd64=https://github.com/stablyai/orca/releases/download/v1.4.271/orca-ide_1.4.271_amd64.deb
SHA256_DEB_amd64=7fad3d721dc0b0920f248353f5391fe0138331791acb64c9677c7a91bf41e755
DEB_FILE_arm64=orca-ide_1.4.271_arm64.deb
DEB_URL_arm64=https://github.com/stablyai/orca/releases/download/v1.4.271/orca-ide_1.4.271_arm64.deb
SHA256_DEB_arm64=2caed34d6f6eb12e265787dacaffed50dc3974674f8baef89b5e367370aa7706

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:
.PHONY: default all one get link download verify build clean
