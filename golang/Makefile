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
VERSION=1.27.0
DIRNAME=go
FILENAME=go$(VERSION).linux-$(ARCH).tar.gz
SHA256_amd64=675c26c449cbb18fc24b74650de1eabbae6e16f64326fd85a283fb3b58280685
SHA256_arm64=51798d2c42d0e1c6ed7fd9f48728b4193abac9e8aad6dbac2fe96a81f5909bda
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
