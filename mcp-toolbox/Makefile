# MCP Toolbox binaries are built from the pinned upstream source release.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=googleapis/mcp-toolbox
PACKAGE=mcp-toolbox
VERSION=1.12.0
RELEASE=1PGSTY
FILENAME=$(PACKAGE)-$(VERSION)-linux-$(ARCH)
SHA256_amd64=593c4aaf399bf69de8b798d0e618dcbd00e421819e4f4128a64f8b3054566b05
SHA256_arm64=7268dc07583049e4dbf0c48f554a555b40ee503eea9e992529316f4197c3ecf8
SHA256=$(SHA256_$(ARCH))

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean
get: download verify

# Source-built binaries are intentionally consumed from the shared cache.
download:
	cp ../tarball/$(FILENAME) $(PACKAGE).bin

verify:
	@if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(PACKAGE).bin" | sha256sum -c -; else echo "$(SHA256)  $(PACKAGE).bin" | shasum -a 256 -c -; fi
	chmod 0755 $(PACKAGE).bin

build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/
clean:
	rm -f $(PACKAGE).bin

.NOTPARALLEL:
.PHONY: default all one get download verify build rpm deb clean
