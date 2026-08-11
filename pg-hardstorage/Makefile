#==============================================================#
# File      :   Makefile
# Ctime     :   2026-08-11
# Mtime     :   2026-08-11
# Desc      :   Makefile shortcuts for pg-hardstorage rpm/deb build
# Path      :   pg-hardstorage/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=cybertec-postgresql/pg_hardstorage
PACKAGE=pg-hardstorage
BINARY=pg_hardstorage
STAGING=payload
VERSION=1.2.1
RELEASE=1PGSTY
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
FILENAME=$(BINARY)_$(VERSION)_linux_$(ARCH).tar.gz
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)
SHA256_amd64=a99fc681186dffb6488328cb3eb2bf5c5b64d81a08421b799bc8afde311988ea
SHA256_arm64=2fca4e05161617605b41d384887273c66960a9601bc97dd4756b9cb0e82b7a3d
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
	test -s $(FILENAME)
	tar -tzf $(FILENAME) $(BINARY) LICENSE >/dev/null

extract:
	rm -rf $(STAGING)
	mkdir -p $(STAGING)
	tar -xzf $(FILENAME) -C $(STAGING) $(BINARY) LICENSE
	test -x $(STAGING)/$(BINARY)
	test -s $(STAGING)/LICENSE

clean:
	rm -rf $(STAGING) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/

.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb one
