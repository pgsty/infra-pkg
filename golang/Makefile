#==============================================================#
# File      :   Makefile
# Ctime     :   2025-01-05
# Mtime     :   2026-01-16
# Desc      :   Makefile shortcuts for golang rpm/deb building
# Path      :   golang/Makefile
# Copyright (C) 2018-2025 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

PACKAGE=golang
VERSION=1.27.1
DIRNAME=go
FILENAME=go$(VERSION).linux-$(ARCH).tar.gz
SHA256_amd64=63d339f0da5ab53635a56f2490a7984dfe12dfcff22ad749f63edaf590168445
SHA256_arm64=3450b45a3f9ee8568792736a5c5e70a1f2e9b36c35a8f74958c03e51d7d92bec
SHA256=$(SHA256_$(ARCH))
WEB_URL=https://go.dev/dl/$(FILENAME)
CURL=curl -fSL --retry 3


default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract build clean
get: download verify extract

link:
	@echo $(PACKAGE) $(VERSION)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)

download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

extract:
	tar -xf $(FILENAME)

clean:
	rm -rf $(DIRNAME) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link download verify extract clean build rpm deb one
