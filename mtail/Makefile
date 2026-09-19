#==============================================================#
# File      :   Makefile
# Ctime     :   2023-10-05
# Mtime     :   2025-04-23
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2023 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME="jaqx0r/mtail"
PACKAGE="mtail"
VERSION=3.4.12
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
DIRNAME="$(PACKAGE)_$(VERSION)_linux_$(ARCH)"
FILENAME="$(DIRNAME).tar.gz"
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)
SHA256_amd64=c5f1cca4891589ffa52a7c3a32e4802c1d4959e31626df953f3d388393720916
SHA256_arm64=acfde7e7cdbf8ecb1865d0cc9bc9dfe7dd657822377bfd5f81405c93b5fedaab
SHA256=$(SHA256_$(ARCH))


default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract build clean
get: download verify extract

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo curl -fSL $(WEB_URL) -o $(FILENAME)

# get latest release info
meta:
	curl --fail --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

# download configured release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else curl -fSL $(WEB_URL) -o $(FILENAME); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

# extract tarball content to current directory
extract:
	tar -xf $(FILENAME)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb LICENSE README.md

# build rpm & deb package
build: rpm deb
rpm:
	../bin/nfpm package --config mtail.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config mtail.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb one
