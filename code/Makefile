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
VERSION=1.138.0
PROXY ?= http://127.0.0.1:8118

DEB_FILE_amd64=code_1.138.0-1789458761_amd64.deb
DEB_FILE_arm64=code_1.138.0-1789458676_arm64.deb
RPM_FILE_amd64=code-1.138.0-1789458812.el8.x86_64.rpm
RPM_FILE_arm64=code-1.138.0-1789458729.el8.aarch64.rpm
DEB_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/7debcd0e2acdea1c52de81bf9ee1620444407dda/code_1.138.0-1789458761_amd64.deb
DEB_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/7debcd0e2acdea1c52de81bf9ee1620444407dda/code_1.138.0-1789458676_arm64.deb
RPM_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/7debcd0e2acdea1c52de81bf9ee1620444407dda/code-1.138.0-1789458812.el8.x86_64.rpm
RPM_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/7debcd0e2acdea1c52de81bf9ee1620444407dda/code-1.138.0-1789458729.el8.aarch64.rpm
SHA256_DEB_amd64=73389cdcef7e66171a2039d1e49b9530e5ed02937e6159d3e6af93484e63cbad
SHA256_DEB_arm64=09760b73fb96ca19f8c6e483ec5b69123f34edd2c762cc9e0faf73fa3d400145
SHA256_RPM_amd64=9f537646dc825d67cc7393dc08b50ec5bb5fa51cf55cedecc8c9dc926425b7c4
SHA256_RPM_arm64=bc8ef30b7093b9ede85907462cfcb741cc4b3cc78c342fe20ab863f2cf921cf8

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
