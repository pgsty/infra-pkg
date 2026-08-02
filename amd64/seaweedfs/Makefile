#==============================================================#
# File      :   Makefile
# Ctime     :   2025-12-04
# Mtime     :   2026-01-16
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME=seaweedfs/seaweedfs
PACKAGE=seaweedfs
VERSION=4.40
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/$(VERSION)
FILENAME=linux_amd64.tar.gz
WEB_URL=https://github.com/$(REPONAME)/releases/download/$(VERSION)/$(FILENAME)
SHA256=0c63aec15429d17e216fdb878a92532188d3e147d7f072645bfec9eb6f992a02

default: all
all: download verify extract build clean
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
	tar -xf $(FILENAME) -C $(PACKAGE)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../../bin/nfpm package --config nfpm.yaml --packager rpm --target ../../dist/rpm.x86_64/
deb:
	../../bin/nfpm package --config nfpm.yaml --packager deb --target ../../dist/deb.amd64/


.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb
