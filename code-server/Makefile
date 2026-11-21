#==============================================================#
# File      :   Makefile
# Desc      :   Download official code-server DEB/RPM packages
# Path      :   code-server/Makefile
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=code-server
VERSION=4.146.0
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=code-server_4.146.0_amd64.deb
DEB_FILE_arm64=code-server_4.146.0_arm64.deb
RPM_FILE_amd64=code-server-4.146.0-amd64.rpm
RPM_FILE_arm64=code-server-4.146.0-arm64.rpm
DEB_URL_amd64=https://github.com/coder/code-server/releases/download/v4.146.0/code-server_4.146.0_amd64.deb
DEB_URL_arm64=https://github.com/coder/code-server/releases/download/v4.146.0/code-server_4.146.0_arm64.deb
RPM_URL_amd64=https://github.com/coder/code-server/releases/download/v4.146.0/code-server-4.146.0-amd64.rpm
RPM_URL_arm64=https://github.com/coder/code-server/releases/download/v4.146.0/code-server-4.146.0-arm64.rpm
SHA256_DEB_amd64=e4825ae7afb441dfa63a4f579c121569de7c7958d2f35c3d18d803c8a3c7018f
SHA256_DEB_arm64=485d87c3c8df5978a89419d4fed0b3e0604a9b203bd177c7effa47bf21055a97
SHA256_RPM_amd64=60a33925ccb764536662b03edfed9913984d82ae9506da40c8c36dc298738ee2
SHA256_RPM_arm64=33ae5dfff175cf05b60b6c0b60e0853a4ba3af8f0ae90ca5fe3c4321d763e5c3

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
