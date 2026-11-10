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
VERSION=1.145.2
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=code_1.145.2-1793945276_amd64.deb
DEB_FILE_arm64=code_1.145.2-1793945203_arm64.deb
RPM_FILE_amd64=code-1.145.2-1793945328.el8.x86_64.rpm
RPM_FILE_arm64=code-1.145.2-1793945254.el8.aarch64.rpm
DEB_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/c4453f8ea430795f941c1b2ff6c9321135a74a02/code_1.145.2-1793945276_amd64.deb
DEB_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/c4453f8ea430795f941c1b2ff6c9321135a74a02/code_1.145.2-1793945203_arm64.deb
RPM_URL_amd64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/c4453f8ea430795f941c1b2ff6c9321135a74a02/code-1.145.2-1793945328.el8.x86_64.rpm
RPM_URL_arm64=https://vscode.download.prss.microsoft.com/dbazure/download/stable/c4453f8ea430795f941c1b2ff6c9321135a74a02/code-1.145.2-1793945254.el8.aarch64.rpm
SHA256_DEB_amd64=aa2bfc5a3db4f0971e8b50ce08d07b1849894a9caca2b0f8ea5b07ac8d68da8d
SHA256_DEB_arm64=a224279b3651eac641bae9e9c9bd3977d93c46af799393f3f368aa1ec55c7c7f
SHA256_RPM_amd64=fb0e0563fd3977e77e53fa46e5da18d52cb04b3bb5be24fd2366ff2008becc02
SHA256_RPM_arm64=9f9a744d717e1ce1f28931e5ce2d1ba146ad87863806acedb2786b39384916e6

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
