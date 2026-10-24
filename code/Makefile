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
VERSION=1.143.1
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=code_1.143.1-1792691907_amd64.deb
DEB_FILE_arm64=code_1.143.1-1792691836_arm64.deb
RPM_FILE_amd64=code-1.143.1-1792691956.el8.x86_64.rpm
RPM_FILE_arm64=code-1.143.1-1792691890.el8.aarch64.rpm
DEB_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/e646868227c3e3a9e3f24277c8c7220be42c0be7/code_1.143.1-1792691907_amd64.deb
DEB_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/e646868227c3e3a9e3f24277c8c7220be42c0be7/code_1.143.1-1792691836_arm64.deb
RPM_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/e646868227c3e3a9e3f24277c8c7220be42c0be7/code-1.143.1-1792691956.el8.x86_64.rpm
RPM_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/e646868227c3e3a9e3f24277c8c7220be42c0be7/code-1.143.1-1792691890.el8.aarch64.rpm
SHA256_DEB_amd64=e459729dee13758960924be07157da44f0ba69503ab5edf4586fcde936bac9b9
SHA256_DEB_arm64=b5163fe68935a3d11c954de08c2ca953532f1ba70204df1bc95e736c1eea31ff
SHA256_RPM_amd64=90d3b9d52a94cd5f0d507b07e4a36bfbe73c87ea8cfdeeaff624c49545adfcf9
SHA256_RPM_arm64=f930aab844a74568af6f362741a5db603952a57c2824fdaab0ac575bbc6a2d02

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
