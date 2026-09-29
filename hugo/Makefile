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
VERSION=0.167.0
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/v$(VERSION)
DIRNAME=$(PACKAGE)_extended_$(VERSION)_linux-$(ARCH)
FILENAME=$(DIRNAME).tar.gz
SHA256_amd64=0163f5c3deddac1f494a1629ddc40c65d18de9d5794facd98f7f96ac2c7d8957
SHA256_arm64=c73eaba13738754b50de4d07606670d5c0cd2eaaf2057af657cec9efd3b01876
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
