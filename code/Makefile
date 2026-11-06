#==============================================================#
# File      :   Makefile
# Desc      :   Download official Visual Studio Code DEB/RPM packages
# Path      :   code/Makefile
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=code
VERSION=1.145.1
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=code_1.145.1-1793903106_amd64.deb
DEB_FILE_arm64=code_1.145.1-1793903186_arm64.deb
RPM_FILE_amd64=code-1.145.1-1793903156.el8.x86_64.rpm
RPM_FILE_arm64=code-1.145.1-1793903239.el8.aarch64.rpm
DEB_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/6bab64e2d12b04d04c0d99c27ff166023efd1dda/code_1.145.1-1793903106_amd64.deb
DEB_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/6bab64e2d12b04d04c0d99c27ff166023efd1dda/code_1.145.1-1793903186_arm64.deb
RPM_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/6bab64e2d12b04d04c0d99c27ff166023efd1dda/code-1.145.1-1793903156.el8.x86_64.rpm
RPM_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/6bab64e2d12b04d04c0d99c27ff166023efd1dda/code-1.145.1-1793903239.el8.aarch64.rpm
SHA256_DEB_amd64=be75503122edad52d2146c8fb29c1a32b733e179da86e4793e878b67cb27b018
SHA256_DEB_arm64=1d445dc03cb22f7467fd774e07d8c3fca5fada572ea9d54ffb5ed3330503d77c
SHA256_RPM_amd64=8f29b08bcb8c57ee1486bcab23c5c8c2d307566a406d1c3925673b291a9f0c4e
SHA256_RPM_arm64=43e9e6fab9f62d6bc4789496e0fbf105673328db2a93becd1e584703e4da17b4

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
