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
VERSION=1.139.1
PROXY ?= http://127.0.0.1:8118

DEB_FILE_amd64=code_1.139.1-1790309529_amd64.deb
DEB_FILE_arm64=code_1.139.1-1790309508_arm64.deb
RPM_FILE_amd64=code-1.139.1-1790309585.el8.x86_64.rpm
RPM_FILE_arm64=code-1.139.1-1790309561.el8.aarch64.rpm
DEB_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/04c0d99f4fb0d8afe6ce4f0c58e31e183ac3e4b1/code_1.139.1-1790309529_amd64.deb
DEB_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/04c0d99f4fb0d8afe6ce4f0c58e31e183ac3e4b1/code_1.139.1-1790309508_arm64.deb
RPM_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/04c0d99f4fb0d8afe6ce4f0c58e31e183ac3e4b1/code-1.139.1-1790309585.el8.x86_64.rpm
RPM_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/04c0d99f4fb0d8afe6ce4f0c58e31e183ac3e4b1/code-1.139.1-1790309561.el8.aarch64.rpm
SHA256_DEB_amd64=cc8e35cf69ff4c7e515e19fa981bf6aba41f61ddb61c79370e9fe460c5dbaf8b
SHA256_DEB_arm64=53cdf61fd870ec9663ea7baa5e4f79014acafc36d8c45b2678a8ce80d72d737d
SHA256_RPM_amd64=b0676fa039df53589acdd5aa55673267cff910d260e875e7c6118144592d05f0
SHA256_RPM_arm64=d067f5cd1b4f9a94e0921cb869ede08db9cb1e289121f2f4657aec3822fd3f5e

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
