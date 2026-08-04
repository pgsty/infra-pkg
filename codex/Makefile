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
VERSION=0.146.0
TAG=rust-v$(VERSION)
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/$(TAG)
TARGET=$(RARCH)-unknown-linux-musl
FILENAME=$(PACKAGE)-$(TARGET).tar.gz
BINARY=$(PACKAGE)-$(TARGET)
WEB_URL=https://github.com/$(REPONAME)/releases/download/$(TAG)/$(FILENAME)
SHA256_amd64=5ba3b9405543953081f661d0854d266f76e2abbe51d41349355a36de7673776a
SHA256_arm64=975bac91562abeedeb8f79636d51a86649b31f34a9de6a3bcb059565b6cf1f87
SHA256=$(SHA256_$(ARCH))
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
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

# verify the official release archive before extraction
verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

# extract tarball content to current directory
extract:
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME) -C $(PACKAGE)
	mv -f $(PACKAGE)/$(BINARY) $(PACKAGE)/$(PACKAGE)
	chmod +x $(PACKAGE)/$(PACKAGE)

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
