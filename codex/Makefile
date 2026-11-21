#==============================================================#
# File      :   Makefile
# Ctime     :   2026-02-18
# Mtime     :   2026-02-18
# Desc      :   Makefile shortcuts for codex rpm/deb building
# Path      :   Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=openai/codex
PACKAGE=codex
VERSION=0.171.0
TAG=rust-v$(VERSION)
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/$(TAG)
TARGET=$(RARCH)-unknown-linux-musl
# upstream's canonical package directory: bin/, codex-resources/, codex-path/
FILENAME=$(PACKAGE)-package-$(TARGET).tar.gz
WEB_URL=https://github.com/$(REPONAME)/releases/download/$(TAG)/$(FILENAME)
SHA256_amd64=8391d67757496bfd14893eca6cbf0c96994bf2627566ff1f018f70600c9ef6b3
SHA256_arm64=d8c43bee6cf11b01eb18b95f4d7961092bc40228180808859e70dabb7784c1c9
SHA256=$(SHA256_$(ARCH))
CURL=curl --http1.1 --retry 5 --retry-delay 2 --retry-connrefused --continue-at - -fL

CACHE=$(PACKAGE)-package-$(VERSION)-linux-$(ARCH).tar.gz

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

# verify the official release archive before extraction
verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

# extract the upstream package directory as-is: never rename or strip its files,
# codex verifies the bundled bwrap against a digest compiled into the binary
extract:
	rm -rf $(PACKAGE)
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME) -C $(PACKAGE)
	test -f $(PACKAGE)/codex-package.json
	test -x $(PACKAGE)/bin/codex

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
