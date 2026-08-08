#==============================================================#
# File      :   Makefile
# Ctime     :   2025-05-23
# Mtime     :   2025-07-04
# Desc      :   Makefile shortcuts for pkg building
# Path      :   Makefile
# Copyright (C) 2018-2023 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME="danvergara/dblab"
PACKAGE="dblab"
VERSION=0.47.4
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
DIRNAME="$(PACKAGE)_$(VERSION)_linux_$(ARCH)"
FILENAME="$(DIRNAME).tar.gz"
SHA256_amd64=aa9555aa70f1c1f3ad7c5f54056c671c82cbdf0dde060ed2eb92db43ac3b97dc
SHA256_arm64=16f554d1d2dc5d08aa6e157119e4f29c08d534e4a3b8ef71232203649d723174
SHA256=$(SHA256_$(ARCH))
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)


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

# download latest release tarball to current directory
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
	../bin/nfpm package --config dblab.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config dblab.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb one
