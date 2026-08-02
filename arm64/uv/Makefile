#==============================================================#
# File      :   Makefile
# Ctime     :   2025-12-24
# Mtime     :   2026-01-16
# Desc      :   Makefile shortcuts for uv rpm/deb building
# Path      :   Makefile
# Copyright (C) 2018-2025 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME=astral-sh/uv
PACKAGE=uv
VERSION=0.12.1
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/$(VERSION)
DIRNAME=$(PACKAGE)-aarch64-unknown-linux-musl
FILENAME=$(DIRNAME).tar.gz
SHA256=ce218dad9eb48a39dd86160bec6291fac7275f20a9cabcc4bc10dd2c757208f8
WEB_URL=https://github.com/$(REPONAME)/releases/download/$(VERSION)/$(FILENAME)
CURL=curl --http1.1 --retry 5 --retry-delay 2 --retry-connrefused --continue-at - -fL

default: all
all: download verify extract build clean
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

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

# extract tarball content to current directory
extract:
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME) --strip-components 1 -C $(PACKAGE)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../../bin/nfpm package --config uv.yaml --packager rpm --target ../../dist/rpm.aarch64/
deb:
	../../bin/nfpm package --config uv.yaml --packager deb --target ../../dist/deb.arm64/

.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb
