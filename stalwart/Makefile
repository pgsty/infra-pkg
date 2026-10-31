#==============================================================#
# File      :   Makefile
# Ctime     :   2026-02-22
# Mtime     :   2026-02-22
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=stalwartlabs/stalwart
PACKAGE=stalwart
VERSION=1.0.1
PROXY ?= http://127.0.0.1:8888
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
FILENAME1=$(PACKAGE)-$(RARCH)-unknown-linux-musl.tar.gz
WEB_URL1=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME1)
SHA256_amd64=6f7cd7926b4744e3cc53cd6201154edacc92217ba64135ccb88e7b12c4c196af
SHA256_arm64=41e1c176c8098463629f75f125b5e0d193b0920d8366272717c52d9e48bac4f4
SHA256=$(SHA256_$(ARCH))
CURL=curl --proxy "$(PROXY)" -fSL --retry 3


CACHE=$(PACKAGE)-$(VERSION)-linux-$(ARCH).tar.gz

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract build clean
get: download verify extract

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL1) -o $(FILENAME1)

# get latest release info
meta:
	curl --fail --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

# download configured release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(CACHE) ]; then cp ../tarball/$(CACHE) $(FILENAME1); else $(CURL) $(WEB_URL1) -o $(FILENAME1); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME1)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME1)" | shasum -a 256 -c -; fi

# extract tarball content to current directory
extract:
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME1) -C $(PACKAGE)
	chmod +x $(PACKAGE)/stalwart

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME1) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb one
