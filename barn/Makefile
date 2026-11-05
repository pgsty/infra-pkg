# Download upstream Barn native packages without repacking.
# Barn 1.x tracks stable upstream releases; all native payloads are preserved.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
REPONAME=pgsty/barn
PACKAGE=barn
VERSION=1.0.0
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=barn_1.0.0_linux_amd64.deb
DEB_FILE_arm64=barn_1.0.0_linux_arm64.deb
RPM_FILE_amd64=barn_1.0.0_linux_amd64.rpm
RPM_FILE_arm64=barn_1.0.0_linux_arm64.rpm
DEB_URL_amd64=https://github.com/pgsty/barn/releases/download/v1.0.0/barn_1.0.0_linux_amd64.deb
DEB_URL_arm64=https://github.com/pgsty/barn/releases/download/v1.0.0/barn_1.0.0_linux_arm64.deb
RPM_URL_amd64=https://github.com/pgsty/barn/releases/download/v1.0.0/barn_1.0.0_linux_amd64.rpm
RPM_URL_arm64=https://github.com/pgsty/barn/releases/download/v1.0.0/barn_1.0.0_linux_arm64.rpm
SHA256_DEB_amd64=2d0426365859346c5b97c20527f289007be4a3cbe9aa7e9edfc0c64bfc09affb
SHA256_DEB_arm64=471e74d1c4cc746caa164fdece0611de8824afb627b988a9aa224cd1ce6ce51d
SHA256_RPM_amd64=f38deb82e76e1329365b23679a1535743519e38d9c029a96eb5abce212998026
SHA256_RPM_arm64=8c3d7a24072b411905eaf0d706be444cf5b60e33500e12c121df982f508f83ee

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
