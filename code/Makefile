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
VERSION=1.145.0
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=code_1.145.0-1793749366_amd64.deb
DEB_FILE_arm64=code_1.145.0-1793748906_arm64.deb
RPM_FILE_amd64=code-1.145.0-1793749416.el8.x86_64.rpm
RPM_FILE_arm64=code-1.145.0-1793748956.el8.aarch64.rpm
DEB_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/a717861c07586a53d83b80d742cd3f59b20a6273/code_1.145.0-1793749366_amd64.deb
DEB_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/a717861c07586a53d83b80d742cd3f59b20a6273/code_1.145.0-1793748906_arm64.deb
RPM_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/a717861c07586a53d83b80d742cd3f59b20a6273/code-1.145.0-1793749416.el8.x86_64.rpm
RPM_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/a717861c07586a53d83b80d742cd3f59b20a6273/code-1.145.0-1793748956.el8.aarch64.rpm
SHA256_DEB_amd64=64cb445811a347df1b5118a17117cfd5ac0ab7e2cc41832351b938364d17cacd
SHA256_DEB_arm64=da4c873ae450a5da60c55e409a15672c01baacfe5d36e2d4b56b06ea0db14c41
SHA256_RPM_amd64=5afd786ccfa8dfcc3360b862ec35e5a51639b6e9806c117a2f6c0745e48590da
SHA256_RPM_arm64=675269c840869463f401c46baa783b283e905477b3cc0c2c46e1c194aefbcdb8

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
