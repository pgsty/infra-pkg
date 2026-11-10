# Download upstream Barn native packages without repacking.
# Barn 1.x tracks stable upstream releases; all native payloads are preserved.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
REPONAME=pgsty/barn
PACKAGE=barn
VERSION=1.1.0
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=barn_1.1.0_linux_amd64.deb
DEB_FILE_arm64=barn_1.1.0_linux_arm64.deb
RPM_FILE_amd64=barn_1.1.0_linux_amd64.rpm
RPM_FILE_arm64=barn_1.1.0_linux_arm64.rpm
DEB_URL_amd64=https://github.com/pgsty/barn/releases/download/v1.1.0/barn_1.1.0_linux_amd64.deb
DEB_URL_arm64=https://github.com/pgsty/barn/releases/download/v1.1.0/barn_1.1.0_linux_arm64.deb
RPM_URL_amd64=https://github.com/pgsty/barn/releases/download/v1.1.0/barn_1.1.0_linux_amd64.rpm
RPM_URL_arm64=https://github.com/pgsty/barn/releases/download/v1.1.0/barn_1.1.0_linux_arm64.rpm
SHA256_DEB_amd64=7307cf04a2307296a26b798068abd9309600f6891ac3c1326035f9fe6810c96b
SHA256_DEB_arm64=2d1980486859f6bf9adfcba5ba24ef72225b9d6b7c9ff965e6592bc09da79cd4
SHA256_RPM_amd64=5cb90d77ea4969905c56b942281821525cd04bebe6a512ba1bc329e6e9085c63
SHA256_RPM_arm64=5e99e0da74e78c1f823c8419b4f153b1434b2a059c41c412584d1635347b9a50

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
