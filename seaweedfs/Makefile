#==============================================================#
# File      :   Makefile
# Ctime     :   2025-12-04
# Mtime     :   2026-01-16
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=seaweedfs/seaweedfs
PACKAGE=seaweedfs
VERSION=4.53
PROXY ?= http://127.0.0.1:8888
CURL=curl --proxy "$(PROXY)" -fSL --retry 3
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/$(VERSION)
FILENAME=linux_$(ARCH).tar.gz
WEB_URL=https://github.com/$(REPONAME)/releases/download/$(VERSION)/$(FILENAME)
SHA256_amd64=d1a7dec9f48d8b33895a0ea8951971defc2dc5312906dcc76fa5a5f74a6ee90d
SHA256_arm64=2eee359ed0ce8a70b711b30162fadda0cd4ea818e13c73d2f156a76f9359717d
SHA256=$(SHA256_$(ARCH))

CACHE=$(PACKAGE)-$(VERSION)-linux-$(ARCH).tar.gz

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

# download configured release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(CACHE) ]; then cp ../tarball/$(CACHE) $(FILENAME); else $(CURL) $(WEB_URL) -o $(FILENAME); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

# extract tarball content to current directory
extract:
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME) -C $(PACKAGE)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb one
