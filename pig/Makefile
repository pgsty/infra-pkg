#==============================================================#
# File      :   Makefile
# Ctime     :   2026-08-11
# Mtime     :   2026-08-12
# Desc      :   Makefile shortcuts for pig rpm/deb build
# Path      :   pig/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=pgsty/pig
PACKAGE=pig
VERSION=1.8.0
RELEASE=1PGSTY
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
FILENAME=$(PACKAGE)-v$(VERSION).linux-$(ARCH).tar.gz
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)
SHA256_amd64=a24a08c1b8d54adcdef5a99ed7b91caeedef1552a1440b1258eb4eb07fb20353
SHA256_arm64=9d23875804f87e78039498245059fd6b765831f027aacfc511ad0ac42711fa7b
SHA256=$(SHA256_$(ARCH))
CURL=curl --http1.1 --retry 5 --retry-delay 2 --retry-connrefused --continue-at - -fL

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract build clean
get: download verify extract

link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)

meta:
	curl --fail --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi
	tar -tzf $(FILENAME) >/dev/null

extract:
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME) -C $(PACKAGE)

clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/

.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb one
