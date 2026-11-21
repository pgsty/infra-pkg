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
VERSION=1.147.0
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=code_1.147.0-1794903003_amd64.deb
DEB_FILE_arm64=code_1.147.0-1794902973_arm64.deb
RPM_FILE_amd64=code-1.147.0-1794903054.el8.x86_64.rpm
RPM_FILE_arm64=code-1.147.0-1794903026.el8.aarch64.rpm
DEB_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/8a14f0cc1b08d531eb83255ea3764ae22aa932b5/code_1.147.0-1794903003_amd64.deb
DEB_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/8a14f0cc1b08d531eb83255ea3764ae22aa932b5/code_1.147.0-1794902973_arm64.deb
RPM_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/8a14f0cc1b08d531eb83255ea3764ae22aa932b5/code-1.147.0-1794903054.el8.x86_64.rpm
RPM_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/8a14f0cc1b08d531eb83255ea3764ae22aa932b5/code-1.147.0-1794903026.el8.aarch64.rpm
SHA256_DEB_amd64=749efcdf5008a8323d76773b836199cdecf708fdb993f0f0544d9475176837ab
SHA256_DEB_arm64=13b65c06a51f573db750878fa671cd89701b5f628e73d5309b7b0c2884814101
SHA256_RPM_amd64=f33ab68ce7db77f5b60de964e33e3c99761cf8e4ce30a8a03f25949b073865ca
SHA256_RPM_arm64=c76c0cbe380d06ad647601bb2d4baf54d2f8e9b980e9488ffc2f7a27f4799cf9

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
