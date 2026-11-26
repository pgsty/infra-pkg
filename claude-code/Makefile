#==============================================================#
# File      :   Makefile
# Desc      :   Download official Claude Code DEB/RPM packages
# Path      :   claude-code/Makefile
#==============================================================#
# Anthropic publishes signed apt/dnf repositories for claude-code:
#   https://code.claude.com/docs/en/setup#install-with-linux-package-managers
# This recipe follows the latest channel. The pinned SHA256 values come from
# the signed repository indexes
# (key 31DDDE24DDFAB679F42D7BD2BAA929FF1A7ECACE), not from the downloads:
#   apt: dists/latest/InRelease -> main/binary-<arch>/Packages
#   rpm: repodata/repomd.xml(.asc) -> repodata/*-primary.xml.gz
# It replaces the obsolete self-maintained claude package and preserves the
# upstream package bytes without nFPM repacking.
# To bump: change VERSION and the four SHA256 values.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=claude-code
VERSION=2.1.331
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=claude-code_2.1.331-1_amd64.deb
DEB_FILE_arm64=claude-code_2.1.331-1_arm64.deb
RPM_FILE_amd64=claude-code-2.1.331-1.x86_64.rpm
RPM_FILE_arm64=claude-code-2.1.331-1.aarch64.rpm
DEB_URL_amd64=https://downloads.claude.ai/claude-code/apt/latest/pool/main/c/claude-code/claude-code_2.1.331-1_amd64.deb
DEB_URL_arm64=https://downloads.claude.ai/claude-code/apt/latest/pool/main/c/claude-code/claude-code_2.1.331-1_arm64.deb
RPM_URL_amd64=https://downloads.claude.ai/claude-code/rpm/latest/Packages/claude-code-2.1.331-1.x86_64.rpm
RPM_URL_arm64=https://downloads.claude.ai/claude-code/rpm/latest/Packages/claude-code-2.1.331-1.aarch64.rpm
SHA256_DEB_amd64=cd9fc7001b0eb0a4a7f000fc07ed9c5c7bb530090637be7546767d359514ffe3
SHA256_DEB_arm64=54de1d5eef8acabb87b8c3ce8ecd570885f90a1c4153ce0333d1dd3057ddfea6
SHA256_RPM_amd64=9219726c1131513be9cbef16b0fce577d944645708bf5226423705420cc398f7
SHA256_RPM_arm64=704711e8901ff8a75f549e24b1722629927df41c5ec88724e7343c2ac057d786

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
