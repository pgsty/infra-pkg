#==============================================================#
# File      :   Makefile
# Ctime     :   2026-10-23
# Mtime     :   2026-10-23
# Desc      :   Makefile shortcuts for pgterm rpm/deb build
# Path      :   pgterm/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=pgrundev/pgterm
PACKAGE=pgterm
VERSION=0.4.0
RELEASE=1PGSTY
TAG=v$(VERSION)
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/$(TAG)
FILENAME=$(PACKAGE)_$(VERSION)_linux_$(ARCH).tar.gz
WEB_URL=https://github.com/$(REPONAME)/releases/download/$(TAG)/$(FILENAME)
# Upstream checksums.txt from the versioned release.
SHA256_amd64=d96a72173b3c382e378438bfb7c0b87c2d3ea63d8ffc9fc0eb89f4a3ec5b62ed
SHA256_arm64=678714a68b1b7bd80bfcb6c0fc3b517bb1d1170f128c219adf9e0ceb9cca9642
SHA256=$(SHA256_$(ARCH))
PROXY ?= http://127.0.0.1:8888
CURL=curl --proxy "$(PROXY)" --http1.1 --retry 5 --retry-delay 2 --retry-connrefused --continue-at - -fL

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract build clean
get: download verify extract

link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)

meta:
	curl --proxy "$(PROXY)" --fail --silent --show-error "https://api.github.com/repos/$(REPONAME)/releases/latest" | tee meta.json

download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

verify:
	test -n "$(SHA256)"
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

extract:
	rm -rf $(PACKAGE)
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME) -C $(PACKAGE) --strip-components=1
	test -s $(PACKAGE)/$(PACKAGE) && test -s $(PACKAGE)/LICENSE && test -s $(PACKAGE)/README.md
	chmod +x $(PACKAGE)/$(PACKAGE)

clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/

.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb one
