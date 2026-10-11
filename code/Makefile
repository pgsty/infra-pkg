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
VERSION=1.141.0
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=code_1.141.0-1791276758_amd64.deb
DEB_FILE_arm64=code_1.141.0-1791276699_arm64.deb
RPM_FILE_amd64=code-1.141.0-1791276813.el8.x86_64.rpm
RPM_FILE_arm64=code-1.141.0-1791276751.el8.aarch64.rpm
DEB_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/2a59476c9bfcb90b3ddc372c36762471b7dfad1c/code_1.141.0-1791276758_amd64.deb
DEB_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/2a59476c9bfcb90b3ddc372c36762471b7dfad1c/code_1.141.0-1791276699_arm64.deb
RPM_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/2a59476c9bfcb90b3ddc372c36762471b7dfad1c/code-1.141.0-1791276813.el8.x86_64.rpm
RPM_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/2a59476c9bfcb90b3ddc372c36762471b7dfad1c/code-1.141.0-1791276751.el8.aarch64.rpm
SHA256_DEB_amd64=d0ff4f7702957d897d2e06956f8d42a08250c5df8339de3bec8190e56f726277
SHA256_DEB_arm64=873d5dac55b7cdb4f0af7172187ae3cc1709f6250331524ad41f1136589e62f2
SHA256_RPM_amd64=6e8ca115fbe125fc2480bd5a853140151aa636a303082d4b8c3194a5c1508b2a
SHA256_RPM_arm64=1440304b14a016f1f5064fa1bab1882e06f201cae51988cc821b7cc0f473df5b

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
