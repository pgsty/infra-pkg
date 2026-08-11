#==============================================================#
# File      :   Makefile
# Ctime     :   2026-08-11
# Mtime     :   2026-08-11
# Desc      :   Makefile shortcuts for crush rpm/deb build
# Path      :   crush/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
XARCH  = $(if $(filter arm64,$(ARCH)),arm64,x86_64)
export ARCH RARCH

REPONAME=charmbracelet/crush
PACKAGE=crush
VERSION=0.88.1
RELEASE=1PGSTY
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
DIRNAME=$(PACKAGE)_$(VERSION)_Linux_$(XARCH)
FILENAME=$(DIRNAME).tar.gz
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)
SHA256_amd64=83374b4fa6c6e1f98f04ac62e11e5c698e05a2da85a793d28c1064e2697dedf4
SHA256_arm64=1a3d291d4c6c25c5a29a4f9c8f2666a2c2ef6817ad6576d59650127b3c57aaf7
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
	curl --fail --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi
	tar -tzf $(FILENAME) >/dev/null

extract:
	rm -rf $(PACKAGE) $(DIRNAME)
	tar -xf $(FILENAME)
	mv $(DIRNAME) $(PACKAGE)

clean:
	rm -rf $(PACKAGE) $(DIRNAME) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/

.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb one
