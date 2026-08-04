#==============================================================#
# File      :   Makefile
# Ctime     :   2025-12-25
# Mtime     :   2026-01-16
# Desc      :   Makefile shortcuts for asciinema rpm/deb building
# Path      :   Makefile
# Copyright (C) 2018-2025 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
NFPM_CONFIG = asciinema.$(ARCH).yaml
export ARCH RARCH

REPONAME=asciinema/asciinema
PACKAGE=asciinema
VERSION=3.2.1
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
FILENAME_amd64=$(PACKAGE)-x86_64-unknown-linux-musl
FILENAME_arm64=$(PACKAGE)-aarch64-unknown-linux-gnu
FILENAME=$(FILENAME_$(ARCH))
SHA256_amd64=bec9781bc8f297a9d3d74ff60205599507f2abba1183578b8b2f22be4c999214
SHA256_arm64=b516a6d896844c0ffbc96e0a55afe4cbcc79216abde0fc64fdda4e39bee421ea
SHA256=$(SHA256_$(ARCH))
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)
CURL=curl -fSL --retry 3

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean
get: download verify

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)

# get latest release info
meta:
	curl --fail --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

# download binary to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi
	chmod +x $(FILENAME)

# verify the official release binary before packaging
verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

# remove binary, rpm & deb files
clean:
	rm -rf $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../bin/nfpm package --config $(NFPM_CONFIG) --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config $(NFPM_CONFIG) --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link meta download verify clean build rpm deb one
