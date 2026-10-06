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
VERSION=1.140.0
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=code_1.140.0-1790759618_amd64.deb
DEB_FILE_arm64=code_1.140.0-1790759479_arm64.deb
RPM_FILE_amd64=code-1.140.0-1790759678.el8.x86_64.rpm
RPM_FILE_arm64=code-1.140.0-1790759531.el8.aarch64.rpm
DEB_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/07f806f999227108933c2e30515b26eecc1fda74/code_1.140.0-1790759618_amd64.deb
DEB_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/07f806f999227108933c2e30515b26eecc1fda74/code_1.140.0-1790759479_arm64.deb
RPM_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/07f806f999227108933c2e30515b26eecc1fda74/code-1.140.0-1790759678.el8.x86_64.rpm
RPM_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/07f806f999227108933c2e30515b26eecc1fda74/code-1.140.0-1790759531.el8.aarch64.rpm
SHA256_DEB_amd64=e5ddfa528d68ce907c92cba18ed4edd7420874fe828cbaaf8e4484aa33530c3b
SHA256_DEB_arm64=e48fc67195d140081bf9363d34dabf07d348e3bf1e78380dfd6abb11e346a9c3
SHA256_RPM_amd64=219a29836626afd12222963908abc1ae96a7491ef3bf04e5dd8819e9ceaaacac
SHA256_RPM_arm64=9e68abc85090ca3f70d12e88efddc26a23553195f4185c53f059e6645803bbf3

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
