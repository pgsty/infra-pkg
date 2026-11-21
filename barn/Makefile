# Download upstream Barn native packages without repacking.
# Barn 1.x tracks stable upstream releases; all native payloads are preserved.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
REPONAME=pgsty/barn
PACKAGE=barn
VERSION=1.2.0
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=barn_1.2.0_linux_amd64.deb
DEB_FILE_arm64=barn_1.2.0_linux_arm64.deb
RPM_FILE_amd64=barn_1.2.0_linux_amd64.rpm
RPM_FILE_arm64=barn_1.2.0_linux_arm64.rpm
DEB_URL_amd64=https://github.com/pgsty/barn/releases/download/v1.2.0/barn_1.2.0_linux_amd64.deb
DEB_URL_arm64=https://github.com/pgsty/barn/releases/download/v1.2.0/barn_1.2.0_linux_arm64.deb
RPM_URL_amd64=https://github.com/pgsty/barn/releases/download/v1.2.0/barn_1.2.0_linux_amd64.rpm
RPM_URL_arm64=https://github.com/pgsty/barn/releases/download/v1.2.0/barn_1.2.0_linux_arm64.rpm
SHA256_DEB_amd64=5ee3f510b0f20506a3fa7408791344d887ec7a58e08f234289958bf5a619bf7b
SHA256_DEB_arm64=37a40b8d2972025d7be92b6c39c8565d72443d6442756dc425cb15a6ad37ddb6
SHA256_RPM_amd64=0f69f195c4ecc2878f55eca79669e9eca5468b960650972886af1538d6645edf
SHA256_RPM_arm64=513f0402a86a286d9c9dfcf7b24c4c0272d97eab9ab78764b745aaeddce954dc

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
