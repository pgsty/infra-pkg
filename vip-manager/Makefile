#==============================================================#
# File      :   Makefile
# Ctime     :   2026-08-08
# Mtime     :   2026-08-08
# Desc      :   Makefile shortcuts for vip-manager rpm/deb build
# Path      :   vip-manager/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),arm64,x86_64)
export ARCH RARCH

REPONAME=cybertec-postgresql/vip-manager
PACKAGE=vip-manager
VERSION=5.0.0
RELEASE=1
TAG=v$(VERSION)
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/$(TAG)
DIRNAME=$(PACKAGE)_$(VERSION)_Linux_$(RARCH)
FILENAME=$(DIRNAME).tar.gz
WEB_URL=https://github.com/$(REPONAME)/releases/download/$(TAG)/$(FILENAME)
SHA256_amd64=0f9d118d2c1e6a7e561406749be008a9a8fca40a59dfdc53897685b8da06d2ef
SHA256_arm64=396165193e3278d53e43be75f70474500d5c2a1c954ac1b316bd8c137272b68b
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

# get configured release metadata
meta:
	curl --fail --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/tags/$(TAG)" | tee meta.json

# download configured release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

# validate the pinned upstream archive before extraction
verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

# extract tarball content to the nFPM staging directory
extract:
	rm -rf $(PACKAGE)
	tar -xzf $(FILENAME)
	mv $(DIRNAME) $(PACKAGE)
	chmod +x $(PACKAGE)/$(PACKAGE)

# remove tarball, staging directory, rpm & deb files
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
