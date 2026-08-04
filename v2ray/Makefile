#==============================================================#
# File      :   Makefile
# Ctime     :   2024-12-14
# Mtime     :   2026-08-02
# Desc      :   Makefile shortcuts for v2ray rpm/deb build
# Path      :   v2ray/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=v2fly/v2ray-core
PACKAGE=v2ray
VERSION=5.51.2
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
DIRNAME_amd64=$(PACKAGE)-linux-64
DIRNAME_arm64=$(PACKAGE)-linux-arm64-v8a
DIRNAME=$(DIRNAME_$(ARCH))
FILENAME=$(DIRNAME).zip
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)
SHA256_amd64=7d034da48fb445fe0acd477ffc8fa9712c68cdf02f1431e3ed9c54c10bf81db3
SHA256_arm64=0fd8a6cee265e2245b7aff460176056f9777b2e47d5b0680e3e635d827340485
SHA256=$(SHA256_$(ARCH))
CURL=curl -fSL --retry 3



default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one:
	$(MAKE) clean
	$(MAKE) download
	$(MAKE) verify
	$(MAKE) extract
	$(MAKE) build
	$(MAKE) clean
get:
	$(MAKE) download
	$(MAKE) verify
	$(MAKE) extract

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)

# get latest release info
meta:
	curl --fail --silent --show-error "https://api.github.com/repos/$(REPONAME)/releases/tags/v$(VERSION)" | tee meta.json

# download latest release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	mkdir -p $(PACKAGE)
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) $(PACKAGE)/; else $(CURL) $(WEB_URL) -o $(PACKAGE)/$(FILENAME); fi

# validate the pinned upstream archive before extraction
verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(PACKAGE)/$(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(PACKAGE)/$(FILENAME)" | shasum -a 256 -c -; fi

# extract tarball content to current directory
extract:
	@echo $(FILENAME)
	cd $(PACKAGE) && unzip -o $(FILENAME)

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
