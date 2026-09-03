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
VERSION=1.135.0
PROXY ?= http://127.0.0.1:8118

DEB_FILE_amd64=code_1.135.0-1787669172_amd64.deb
DEB_FILE_arm64=code_1.135.0-1787669187_arm64.deb
RPM_FILE_amd64=code-1.135.0-1787669223.el8.x86_64.rpm
RPM_FILE_arm64=code-1.135.0-1787669237.el8.aarch64.rpm
DEB_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/08d4889f9ec4a1685d257b9b95de036c8e1ce1e5/$(DEB_FILE_amd64)
DEB_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/08d4889f9ec4a1685d257b9b95de036c8e1ce1e5/$(DEB_FILE_arm64)
RPM_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/08d4889f9ec4a1685d257b9b95de036c8e1ce1e5/$(RPM_FILE_amd64)
RPM_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/08d4889f9ec4a1685d257b9b95de036c8e1ce1e5/$(RPM_FILE_arm64)
SHA256_DEB_amd64=e8101720f0a48f8e6ae5a4112d10ffea5f13d298e7d0a7012b4e36eebc53022c
SHA256_DEB_arm64=20f1717805ed723c8846e14df3280c6132a663ff71e32068aaa70f3e4c8b1ca4
SHA256_RPM_amd64=6073b53d088aacf3ac7ca66ca4a417e45f6b880d84582b483bc62794aca6c681
SHA256_RPM_arm64=84a2f187a5c5074d57c208ac3e11ec11e187d2534c361c333700665eca9efe06

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
