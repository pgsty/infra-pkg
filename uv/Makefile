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
VERSION=0.13.0
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/$(VERSION)
DIRNAME=$(PACKAGE)-$(RARCH)-unknown-linux-musl
FILENAME=$(DIRNAME).tar.gz
CACHE=$(PACKAGE)-v$(VERSION)-linux-$(ARCH).tar.gz
SHA256_amd64=b0828fc4cdc47d65951e94b5f0a15a5364420e8dcd88723f3b21e7a2eb30bbc3
SHA256_arm64=281ca6cf43f4e26e35474839ad4861be86de42af2682f74134460f5b2071b96d
SHA256=$(SHA256_$(ARCH))
WEB_URL=https://github.com/$(REPONAME)/releases/download/$(VERSION)/$(FILENAME)
CURL=curl --http1.1 --retry 5 --retry-delay 2 --retry-connrefused --continue-at - -fL

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
	curl --fail --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

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
