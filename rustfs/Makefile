#==============================================================#
# File      :   Makefile
# Ctime     :   2025-12-04
# Mtime     :   2026-08-08
# Desc      :   Makefile shortcuts for rustfs rpm/deb build
# Path      :   rustfs/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=rustfs/rustfs
PACKAGE=rustfs
VERSION=1.0.0
RELEASE=1PGSTY
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/$(VERSION)
FILENAME=$(PACKAGE)-linux-$(RARCH)-musl-v$(VERSION).zip
WEB_URL=https://github.com/$(REPONAME)/releases/download/$(VERSION)/$(FILENAME)
SHA256_amd64=c30a95b76546f25122c9ca387090ddb30c391ca5605621b0d7c881703c0f21c8
SHA256_arm64=88202c0446d0aa31fa475b1dc8cdb92f6d32e62d6f34a63f2018899c1943f100
SHA256=$(SHA256_$(ARCH))
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
	curl --fail --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/tags/$(VERSION)" | tee meta.json

# download latest release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

# validate the pinned upstream archive before extraction
verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

# extract zip content to current directory
extract:
	mkdir -p $(PACKAGE)
	unzip -o $(FILENAME) -d $(PACKAGE)
	chmod +x $(PACKAGE)/rustfs

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
