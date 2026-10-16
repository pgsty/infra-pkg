#==============================================================#
# File      :   Makefile
# Ctime     :   2025-01-20
# Mtime     :   2025-01-20
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2025 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=gohugoio/hugo
PACKAGE=hugo
VERSION=0.168.0
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/v$(VERSION)
DIRNAME=$(PACKAGE)_extended_$(VERSION)_linux-$(ARCH)
FILENAME=$(DIRNAME).tar.gz
SHA256_amd64=787f100057328824f38c6ad7c87ff10d6451ae0a7bc39cedaad0dd2bcde17e53
SHA256_arm64=b975ba150a464f57115bdf6cbf6638224906461fdcf863821ec983f8602a442c
SHA256=$(SHA256_$(ARCH))
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)
CURL=curl -fSL --retry 3

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
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

# extract tarball content to current directory
extract:
	@echo $(FILENAME)
	tar -xf $(FILENAME)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb LICENSE README.md

# build rpm & deb package
build: rpm deb
rpm:
	../bin/nfpm package --config hugo.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config hugo.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb one
