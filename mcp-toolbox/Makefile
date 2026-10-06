# MCP Toolbox binaries are built from the pinned upstream source release.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=googleapis/mcp-toolbox
PACKAGE=mcp-toolbox
VERSION=1.13.1
RELEASE=2PGSTY
FILENAME=$(PACKAGE)-$(VERSION)-linux-$(ARCH)
SHA256_amd64=2afcaa561b6baae4de77858bdaaf21b889fcfade02e1123dd53bee0b9f1500bd
SHA256_arm64=ddea02768003d0f5f2fc8ff83548b538f8344d64c6f099dfaa0fa80281c27740
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
