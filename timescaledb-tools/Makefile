#==============================================================#
# File      :   Makefile
# Ctime     :   2024-07-25
# Mtime     :   2025-11-23
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME1=timescale/timescaledb-tune
REPONAME2=timescale/timescaledb-parallel-copy
PACKAGE=timescaledb-tools
VERSION=0.19.0
VERSION2=0.13.0
RELEASE_PAGE1=https://github.com/$(REPONAME1)/releases/tag/v$(VERSION)
RELEASE_PAGE2=https://github.com/$(REPONAME2)/releases/tag/v$(VERSION2)
FILENAME1=timescaledb-tune
FILENAME2=timescaledb-parallel-copy
CACHE1=$(FILENAME1)-v$(VERSION)-linux-$(ARCH)
CACHE2=$(FILENAME2)-v$(VERSION2)-linux-$(ARCH)
SHA2561_amd64=23a1486d2c67c9254665850198e7950518621fa3c97f4f13f73141387ca87839
SHA2561_arm64=3fcee65930d6377f2bdd534860ba5cf4a41e55a64d70fd992ef5d445de32af89
SHA2561=$(SHA2561_$(ARCH))
SHA2562_amd64=bb5528396bab947c00d66057f8328347173f305dfd96988b225ae606bd80544b
SHA2562_arm64=5ac61d17cf26c905f44623598032f95f49482238bf65953cee9441fa902f6760
SHA2562=$(SHA2562_$(ARCH))
CURL=curl --http1.1 --retry 5 --retry-delay 2 --retry-connrefused --fail --silent --show-error --location


default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean
get: download verify

# print upstream release pages
link:
	@echo $(REPONAME1) $(VERSION) on $(RELEASE_PAGE1)
	@echo $(REPONAME2) $(VERSION2) on $(RELEASE_PAGE2)

# get pinned release info
meta:
	$(CURL) "https://api.github.com/repos/$(REPONAME1)/releases/tags/v$(VERSION)" | tee meta.json
	$(CURL) "https://api.github.com/repos/$(REPONAME2)/releases/tags/v$(VERSION2)" | tee meta2.json

# copy locally built Linux binaries from the architecture cache
download:
	cp ../tarball/$(CACHE1) $(FILENAME1)
	cp ../tarball/$(CACHE2) $(FILENAME2)

# verify the exact cached inputs
verify:
	@if command -v sha256sum >/dev/null 2>&1; then \
		printf '%s  %s\n%s  %s\n' "$(SHA2561)" "$(FILENAME1)" "$(SHA2562)" "$(FILENAME2)" | sha256sum -c -; \
	else \
		printf '%s  %s\n%s  %s\n' "$(SHA2561)" "$(FILENAME1)" "$(SHA2562)" "$(FILENAME2)" | shasum -a 256 -c -; \
	fi

# remove copied binaries and local package outputs
clean:
	rm -f $(FILENAME1) $(FILENAME2) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link meta download verify clean build rpm deb one
