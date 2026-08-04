#==============================================================#
# File      :   Makefile
# Ctime     :   2025-01-04
# Mtime     :   2026-01-16
# Desc      :   Makefile shortcuts for rpm/deb building
# Path      :   Makefile
# Copyright (C) 2018-2025 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=anomalyco/opencode
PACKAGE=opencode
VERSION=1.18.11
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
ASSET_amd64=$(PACKAGE)-linux-x64-baseline.tar.gz
ASSET_arm64=$(PACKAGE)-linux-arm64.tar.gz
ASSET=$(ASSET_$(ARCH))
FILENAME_amd64=$(PACKAGE)-$(VERSION)-linux-x64-baseline.tar.gz
FILENAME_arm64=$(PACKAGE)-$(VERSION)-linux-arm64.tar.gz
FILENAME=$(FILENAME_$(ARCH))
SHA256_amd64=3b97ef1d5f27a0460b5fd64a59919009d16fb61f5138725b77fef51ad2d09a20
SHA256_arm64=03e07aa461ac241dfa8c7ab54ed58c7a0e911c62fc3cb490b83e4fb3424eb73b
SHA256=$(SHA256_$(ARCH))
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(ASSET)

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
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME) --strip-components 0 -C $(PACKAGE)

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
