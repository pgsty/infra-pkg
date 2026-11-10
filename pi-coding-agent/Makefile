#==============================================================#
# File      :   Makefile
# Ctime     :   2026-11-10
# Mtime     :   2026-11-10
# Desc      :   Makefile shortcuts for pi coding agent rpm/deb building
# Path      :   pi-coding-agent/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

# The package is named after upstream's npm package: Debian already ships an
# unrelated `pi` (from cln) that owns /usr/bin/pi.
REPONAME=earendil-works/pi
PACKAGE=pi-coding-agent
VERSION=1.5.1
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
# Upstream ships a directory, not a single binary: pi loads package.json, themes,
# wasm and docs from the directory of its own executable.
DIRNAME=pi
ASSET_amd64=pi-linux-x64.tar.gz
ASSET_arm64=pi-linux-arm64.tar.gz
ASSET=$(ASSET_$(ARCH))
FILENAME_amd64=pi-$(VERSION)-linux-x64.tar.gz
FILENAME_arm64=pi-$(VERSION)-linux-arm64.tar.gz
FILENAME=$(FILENAME_$(ARCH))
# from the SHA256SUMS asset of the release
SHA256_amd64=cb69979c0a8162bf22bcee0762f3c3701a45b51b552fa16a736d467c6068509f
SHA256_arm64=98f1762f56adc5703f931996ae802216dad490dde0b6793aed1e3bb0383df1f7
SHA256=$(SHA256_$(ARCH))
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(ASSET)
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

# download configured release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

# extract tarball content to current directory (the archive root is pi/)
extract:
	rm -rf $(DIRNAME)
	tar -xf $(FILENAME)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(DIRNAME) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb one
