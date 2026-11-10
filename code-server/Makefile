#==============================================================#
# File      :   Makefile
# Desc      :   Download official code-server DEB/RPM packages
# Path      :   code-server/Makefile
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=code-server
VERSION=4.145.2
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=code-server_4.145.2_amd64.deb
DEB_FILE_arm64=code-server_4.145.2_arm64.deb
RPM_FILE_amd64=code-server-4.145.2-amd64.rpm
RPM_FILE_arm64=code-server-4.145.2-arm64.rpm
DEB_URL_amd64=https://github.com/coder/code-server/releases/download/v4.145.2/code-server_4.145.2_amd64.deb
DEB_URL_arm64=https://github.com/coder/code-server/releases/download/v4.145.2/code-server_4.145.2_arm64.deb
RPM_URL_amd64=https://github.com/coder/code-server/releases/download/v4.145.2/code-server-4.145.2-amd64.rpm
RPM_URL_arm64=https://github.com/coder/code-server/releases/download/v4.145.2/code-server-4.145.2-arm64.rpm
SHA256_DEB_amd64=7eddbdeaab34380bde3ac3bbadce58fe2f5722c4877f331ea593ae797c2517e1
SHA256_DEB_arm64=0fa9af7f602536b1e320a17d32bb1a85e4a924fdc09283898f1bea73d2a5c1e7
SHA256_RPM_amd64=282543b992f61f63a864e11d952e1fb7ba42778fc12ea711b92cd75f11f45684
SHA256_RPM_arm64=0ba251ff8c96b11282ca7c1bdef4016f326051b61cea5cd66aaa3d1a241c8a6b

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
