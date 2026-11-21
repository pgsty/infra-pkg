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
VERSION=2.1.330
PROXY ?= http://127.0.0.1:8888

DEB_FILE_amd64=claude-code_2.1.330-1_amd64.deb
DEB_FILE_arm64=claude-code_2.1.330-1_arm64.deb
RPM_FILE_amd64=claude-code-2.1.330-1.x86_64.rpm
RPM_FILE_arm64=claude-code-2.1.330-1.aarch64.rpm
DEB_URL_amd64=https://downloads.claude.ai/claude-code/apt/latest/pool/main/c/claude-code/claude-code_2.1.330-1_amd64.deb
DEB_URL_arm64=https://downloads.claude.ai/claude-code/apt/latest/pool/main/c/claude-code/claude-code_2.1.330-1_arm64.deb
RPM_URL_amd64=https://downloads.claude.ai/claude-code/rpm/latest/Packages/claude-code-2.1.330-1.x86_64.rpm
RPM_URL_arm64=https://downloads.claude.ai/claude-code/rpm/latest/Packages/claude-code-2.1.330-1.aarch64.rpm
SHA256_DEB_amd64=07495980f89fc1e62690c333a580e25d8c431306dfa5b112d5980be4778360b5
SHA256_DEB_arm64=9cc220109c4853e03492013088de89c8ca3923c718460b3c9e60d81c12a34414
SHA256_RPM_amd64=ad26fb886ea3d57aaca3d1320419aa9aa89fed4985f0314012956462b23579a7
SHA256_RPM_arm64=97a8f08589bcba7fefd53c264ea6954b27f4a66b6b28bcfadf4563fb0be04334

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean

include ../mk/vendor-direct.mk

.NOTPARALLEL:

.PHONY: default all one get link download verify build clean
