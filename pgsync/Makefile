#==============================================================#
# File      :   Makefile
# Ctime     :   2026-10-23
# Mtime     :   2026-10-23
# Desc      :   Makefile shortcuts for pgsync rpm/deb building
# Path      :   pgsync/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=pgrundev/pgsync
PACKAGE=pgsync
VERSION=0.1.1
RELEASE=1PGSTY
TAG=v$(VERSION)
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/$(TAG)
FILENAME=$(PACKAGE)_$(VERSION)_linux_$(ARCH).tar.gz
WEB_URL=https://github.com/$(REPONAME)/releases/download/$(TAG)/$(FILENAME)
SHA256_amd64=47ba6a00976eb704a3ac8bde416ee9992cb4dc1d8dcd284b04df3654effea127
SHA256_arm64=57aa4180069f667358108e9ac1a35ebee847e6805bafb11ae04f798f231d397c
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

# v0.1.1 is a GitHub prerelease; /releases/latest intentionally excludes it.
meta:
	curl --proxy "$(PROXY)" --fail --silent --show-error "https://api.github.com/repos/$(REPONAME)/releases/tags/$(TAG)" | tee meta.json

download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

verify:
	test -n "$(SHA256)"
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

extract:
	rm -rf $(PACKAGE)
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME) -C $(PACKAGE) --strip-components=1
	test -s $(PACKAGE)/$(PACKAGE)
	test -s $(PACKAGE)/README.md
	test -s $(PACKAGE)/examples/pgsync.yaml
	cmp LICENSE $(PACKAGE)/LICENSE
	chmod +x $(PACKAGE)/$(PACKAGE)

clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/

.NOTPARALLEL:
.PHONY: default all one get link meta download verify extract clean build rpm deb
