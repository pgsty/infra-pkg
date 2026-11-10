#==============================================================#
# File      :   Makefile
# Desc      :   Download official Claude Code DEB/RPM packages
# Path      :   claude-code/Makefile
#==============================================================#
# Anthropic publishes signed apt/dnf repositories for claude-code:
#   https://code.claude.com/docs/en/setup#install-with-linux-package-managers
# The pinned SHA256 values come from the signed repository indexes
# (key 31DDDE24DDFAB679F42D7BD2BAA929FF1A7ECACE), not from the downloads:
#   apt: dists/latest/InRelease -> main/binary-<arch>/Packages
#   rpm: repodata/repomd.xml(.asc) -> repodata/*-primary.xml.gz
# To bump: change VERSION and the four SHA256 values.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DIRECT=1
PACKAGE=claude-code
VERSION=2.1.322
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=claude-code_$(VERSION)-1_amd64.deb
DEB_FILE_arm64=claude-code_$(VERSION)-1_arm64.deb
RPM_FILE_amd64=claude-code-$(VERSION)-1.x86_64.rpm
RPM_FILE_arm64=claude-code-$(VERSION)-1.aarch64.rpm
DEB_URL_amd64=https://downloads.claude.ai/claude-code/apt/latest/pool/main/c/claude-code/claude-code_$(VERSION)-1_amd64.deb
DEB_URL_arm64=https://downloads.claude.ai/claude-code/apt/latest/pool/main/c/claude-code/claude-code_$(VERSION)-1_arm64.deb
RPM_URL_amd64=https://downloads.claude.ai/claude-code/rpm/latest/Packages/claude-code-$(VERSION)-1.x86_64.rpm
RPM_URL_arm64=https://downloads.claude.ai/claude-code/rpm/latest/Packages/claude-code-$(VERSION)-1.aarch64.rpm
SHA256_DEB_amd64=f7409eba75e40275a457771e4669f9921d73080ee4f9d10ba2c6edf61d3faff7
SHA256_DEB_arm64=24fc251bf36ff3f70a5573550ab059a5a858477ce5887307f4062bab94c31858
SHA256_RPM_amd64=cafdfb1c4b0ab327f9ca619d99615c5626533106be995873d333a99f742603d5
SHA256_RPM_arm64=f27404a38aa387d670068947b1112922c8c0c4de7263b5628b12b096cd48fe71

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
