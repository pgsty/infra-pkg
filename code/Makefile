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
VERSION=1.143.0
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=code_1.143.0-1792533444_amd64.deb
DEB_FILE_arm64=code_1.143.0-1792533331_arm64.deb
RPM_FILE_amd64=code-1.143.0-1792533501.el8.x86_64.rpm
RPM_FILE_arm64=code-1.143.0-1792533380.el8.aarch64.rpm
DEB_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/2d0b7506a36c1d6db9a466440131a8e01eab2289/code_1.143.0-1792533444_amd64.deb
DEB_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/2d0b7506a36c1d6db9a466440131a8e01eab2289/code_1.143.0-1792533331_arm64.deb
RPM_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/2d0b7506a36c1d6db9a466440131a8e01eab2289/code-1.143.0-1792533501.el8.x86_64.rpm
RPM_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/2d0b7506a36c1d6db9a466440131a8e01eab2289/code-1.143.0-1792533380.el8.aarch64.rpm
SHA256_DEB_amd64=f045a886dbfd1aa47ec49dd6880d79a95570c9afde627510897b5cf692db5f2a
SHA256_DEB_arm64=f2e0ffb9f370b46b8ddbe49fa099f436e9f6344579ddd15a534bc7825ab4ed98
SHA256_RPM_amd64=624da32c2c3634cffe741c8a76218aa82e747f25eef5d03ea05133de617bc319
SHA256_RPM_arm64=748258df06e3c6c7c94081d3d53ad265ca3e1217840928e81001546cff376252

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
