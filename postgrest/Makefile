#==============================================================#
# File      :   Makefile
# Ctime     :   2025-01-08
# Mtime     :   2026-08-02
# Desc      :   Makefile shortcuts for postgrest rpm/deb build
# Path      :   postgrest/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
NFPM_CONFIG = nfpm.$(ARCH).yaml
export ARCH RARCH

REPONAME=PostgREST/postgrest
PACKAGE=postgrest
VERSION=16.3
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
DIRNAME_amd64=$(PACKAGE)-v$(VERSION)-linux-static-x86-64
DIRNAME_arm64=$(PACKAGE)-v$(VERSION)-linux-static-aarch64
DIRNAME=$(DIRNAME_$(ARCH))
FILENAME=$(DIRNAME).tar.xz
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)
SHA256_amd64=4eb414eb948c8800863cc8c9896a17b611b2dccf9ff581f4d57f42ec9ccee40d
SHA256_arm64=25bb1eab438f92c26514ff126104400562b8560d0352f128606c3fb726eac242
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
	curl --fail --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

# download latest release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

# validate the pinned upstream archive before extraction
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
	../bin/nfpm package --config $(NFPM_CONFIG) --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config $(NFPM_CONFIG) --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb one
