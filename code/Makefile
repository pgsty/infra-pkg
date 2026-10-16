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
VERSION=1.142.0
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=code_1.142.0-1792035033_amd64.deb
DEB_FILE_arm64=code_1.142.0-1792034974_arm64.deb
RPM_FILE_amd64=code-1.142.0-1792035085.el8.x86_64.rpm
RPM_FILE_arm64=code-1.142.0-1792035024.el8.aarch64.rpm
DEB_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/6d62b1d5dace93a33b3a6d3eca1317bd5e15bcb1/code_1.142.0-1792035033_amd64.deb
DEB_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/6d62b1d5dace93a33b3a6d3eca1317bd5e15bcb1/code_1.142.0-1792034974_arm64.deb
RPM_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/6d62b1d5dace93a33b3a6d3eca1317bd5e15bcb1/code-1.142.0-1792035085.el8.x86_64.rpm
RPM_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/6d62b1d5dace93a33b3a6d3eca1317bd5e15bcb1/code-1.142.0-1792035024.el8.aarch64.rpm
SHA256_DEB_amd64=33454f7d2d7bc79a5925b3e794d106fb454a10c6a635ddfeb908a63659a44ec5
SHA256_DEB_arm64=036b445fe4c634f0917cb0d09f4ce43048da1b2797d3fd2169c645ea9a261af8
SHA256_RPM_amd64=973a0bb626c76c86c4edc81d19ca414427d000b14420f3457182daa9fc8fe430
SHA256_RPM_arm64=292fb01a86f992d86e218f2079f11dc0c6ff3473f0e4f3168bb5919621587497

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
