#==============================================================#
# File      :   Makefile
# Desc      :   Build the Loki RPM/DEB package
# Path      :   loki/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=grafana/loki
PACKAGE=loki
VERSION=3.7.7
RELEASE=1PGSTY
ASSET=loki-linux-$(ARCH).zip
FILENAME=loki-$(VERSION)-linux-$(ARCH).zip
SHA256_amd64=2ddedde361e7026f15627c28ef2ae79a3a82b4a89434795995891edf733a05ff
SHA256_arm64=bfccc75f573eeaa34a6346803f076e066bbf971664b8130b800d2b9d89c3a694
SHA256=$(SHA256_$(ARCH))
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(ASSET)
PROXY ?= http://127.0.0.1:8118
CURL=curl --fail --show-error --location --retry 3 --proxy $(PROXY)

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract build clean
get: download verify extract

link:
	@echo $(PACKAGE) $(VERSION)-$(RELEASE) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)

meta:
	curl --fail --silent --show-error --proxy $(PROXY) "https://api.github.com/repos/$(REPONAME)/releases/tags/v$(VERSION)" | tee meta.json

download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

extract:
	mkdir -p $(PACKAGE)
	unzip -o $(FILENAME) -d $(PACKAGE)
	mv $(PACKAGE)/loki-linux-$(ARCH) $(PACKAGE)/loki.bin

clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	mkdir -p ../dist/rpm/
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	mkdir -p ../dist/deb/
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/

.NOTPARALLEL:

.PHONY: default all one get link meta download verify extract clean build rpm deb
