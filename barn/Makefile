# Download upstream Barn native packages without repacking.
# Barn 1.x tracks stable upstream releases; all native payloads are preserved.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
REPONAME=pgsty/barn
PACKAGE=barn
VERSION=1.3.0
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=barn_1.3.0_linux_amd64.deb
DEB_FILE_arm64=barn_1.3.0_linux_arm64.deb
RPM_FILE_amd64=barn_1.3.0_linux_amd64.rpm
RPM_FILE_arm64=barn_1.3.0_linux_arm64.rpm
DEB_URL_amd64=https://github.com/pgsty/barn/releases/download/v1.3.0/barn_1.3.0_linux_amd64.deb
DEB_URL_arm64=https://github.com/pgsty/barn/releases/download/v1.3.0/barn_1.3.0_linux_arm64.deb
RPM_URL_amd64=https://github.com/pgsty/barn/releases/download/v1.3.0/barn_1.3.0_linux_amd64.rpm
RPM_URL_arm64=https://github.com/pgsty/barn/releases/download/v1.3.0/barn_1.3.0_linux_arm64.rpm
SHA256_DEB_amd64=53841b91088b86b044f48d12a37e1fd77a40a8777edd5b0cc9fb41004449a205
SHA256_DEB_arm64=a259363675820890408fce498035f2e15ba9133062a78f02f18e6fdd1edb9b3a
SHA256_RPM_amd64=6886b835cdfaa352d99d35cf3925e00fa135ce7a77196396f30a3337700bcd6d
SHA256_RPM_arm64=59f59071bc8e4ef7820aa6fca3db3a91f49871f6886a50f6b4c44b47bca47e4e

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
