# Download upstream Barn native packages without repacking.
# The 0.9.0 upstream prerelease is explicitly included in this batch.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
REPONAME=pgsty/barn
PACKAGE=barn
VERSION=0.9.0
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=barn_0.9.0_linux_amd64.deb
DEB_FILE_arm64=barn_0.9.0_linux_arm64.deb
RPM_FILE_amd64=barn_0.9.0_linux_amd64.rpm
RPM_FILE_arm64=barn_0.9.0_linux_arm64.rpm
DEB_URL_amd64=https://github.com/pgsty/barn/releases/download/v0.9.0/barn_0.9.0_linux_amd64.deb
DEB_URL_arm64=https://github.com/pgsty/barn/releases/download/v0.9.0/barn_0.9.0_linux_arm64.deb
RPM_URL_amd64=https://github.com/pgsty/barn/releases/download/v0.9.0/barn_0.9.0_linux_amd64.rpm
RPM_URL_arm64=https://github.com/pgsty/barn/releases/download/v0.9.0/barn_0.9.0_linux_arm64.rpm
SHA256_DEB_amd64=7e434efc55d918a101b97a219fab8a724a11064dca40420528827a23539a11ef
SHA256_DEB_arm64=7edb264ce032a1da5fac861040b8320f97150cafd42beedd0758ed25e83d24fc
SHA256_RPM_amd64=413c8cbc1df675c37d2e37ea21bc085a77c6bf094fd7b58aa629a9d0e2fa10e3
SHA256_RPM_arm64=011940162fa94474a5e8926c9483a4b61c1f4171b99dba6a4466687e75d9b75a

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
