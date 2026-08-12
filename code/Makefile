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
VERSION=1.133.0
PROXY ?= http://127.0.0.1:8118

DEB_FILE_amd64=code_1.133.0-1786487972_amd64.deb
DEB_FILE_arm64=code_1.133.0-1786487973_arm64.deb
RPM_FILE_amd64=code-1.133.0-1786488022.el8.x86_64.rpm
RPM_FILE_arm64=code-1.133.0-1786488026.el8.aarch64.rpm
DEB_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/a5b500951314efd502d07465bd138dfbd714a960/$(DEB_FILE_amd64)
DEB_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/a5b500951314efd502d07465bd138dfbd714a960/$(DEB_FILE_arm64)
RPM_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/a5b500951314efd502d07465bd138dfbd714a960/$(RPM_FILE_amd64)
RPM_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/a5b500951314efd502d07465bd138dfbd714a960/$(RPM_FILE_arm64)
SHA256_DEB_amd64=d064e87e22f556b8a91e1354b5227e340597324e52886dbb288551596b00e34a
SHA256_DEB_arm64=b20bfb21c5b3656e3411391c5c18df1782aedd7cd3bda0b9c08363ea261fca4b
SHA256_RPM_amd64=be76ca032b22756033c3565f1140db946a8a0c06623a22eba55f08f8e4f8d76f
SHA256_RPM_arm64=2f633d8c3eb449f2c3bbcb24f9b8a6d52f2065b7acfcd973bc78d575da81a4b2

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
