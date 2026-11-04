#==============================================================#
# File      :   Makefile
# Ctime     :   2025-12-24
# Mtime     :   2026-01-16
# Desc      :   Makefile shortcuts for uv rpm/deb building
# Path      :   Makefile
# Copyright (C) 2018-2025 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=astral-sh/uv
PACKAGE=uv
VERSION=0.13.7
PROXY ?= http://127.0.0.1:8888
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/$(VERSION)
DIRNAME=$(PACKAGE)-$(RARCH)-unknown-linux-musl
FILENAME=$(DIRNAME).tar.gz
CACHE=$(PACKAGE)-v$(VERSION)-linux-$(ARCH).tar.gz
SHA256_amd64=287491da03f2a785c70fa75b13e1f849918c2f2b5415fe84876b8214eeb792f9
SHA256_arm64=2d3ec076a0c4c0e8250bb6418c44080828b544f1a3be0b6e46adf9fb6923de45
SHA256=$(SHA256_$(ARCH))
WEB_URL=https://github.com/$(REPONAME)/releases/download/$(VERSION)/$(FILENAME)
CURL=curl --proxy "$(PROXY)" --http1.1 --retry 5 --retry-delay 2 --retry-connrefused --continue-at - -fL

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract build clean
get: download verify extract

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)

# get latest release info
meta:
	$(CURL) "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

# download latest release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(CACHE) ]; then cp ../tarball/$(CACHE) $(FILENAME); else $(CURL) $(WEB_URL) -o $(FILENAME); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

# extract tarball content to current directory
extract:
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME) --strip-components 1 -C $(PACKAGE)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../bin/nfpm package --config uv.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config uv.yaml --packager deb --target ../dist/deb/

.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb one
