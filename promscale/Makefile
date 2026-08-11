#==============================================================#
# File      :   Makefile
# Ctime     :   2026-08-11
# Mtime     :   2026-08-11
# Desc      :   Makefile shortcuts for archived promscale rpm/deb build
# Path      :   promscale/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
UARCH  = $(if $(filter arm64,$(ARCH)),arm64,x86_64)
export ARCH RARCH

REPONAME=timescale/promscale
PACKAGE=promscale
VERSION=0.17.0
RELEASE=1PGSTY
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/$(VERSION)
FILENAME=$(PACKAGE)_$(VERSION)_Linux_$(UARCH)
WEB_URL=https://github.com/$(REPONAME)/releases/download/$(VERSION)/$(FILENAME)
SHA256_amd64=65b805b58bad221f646f37611a0c05775380c4c95a6d1fc60bc6e2d8be5e6bae
SHA256_arm64=6c046edb20037af73172c2e33cfb792f0883cfc9eb9d4922a8d1c896bb63b568
SHA256=$(SHA256_$(ARCH))
CURL=curl --http1.1 --retry 5 --retry-delay 2 --retry-connrefused --continue-at - -fL

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract build clean
get: download verify extract

link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)

meta:
	curl --fail --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/tags/$(VERSION)" | tee meta.json

download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi
	test -s $(FILENAME)

extract:
	mkdir -p $(PACKAGE)
	cp $(FILENAME) $(PACKAGE)/$(PACKAGE)
	chmod +x $(PACKAGE)/$(PACKAGE)

clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/

.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb one
