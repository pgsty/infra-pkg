#==============================================================#
# File      :   Makefile
# Desc      :   Build the Loki logcli RPM/DEB package
# Path      :   logcli/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=grafana/loki
PACKAGE=logcli
VERSION=3.6.7
RELEASE=1PGSTY
FILENAME=logcli-linux-$(ARCH).zip
SHA256_amd64=b68f02dbd3e85a4259770098247000794caceec27a24e7653152545e6faaae21
SHA256_arm64=88eb1939c1a45f72ae31e65124317c77d4f84b371d3fd27db1ba782c33542bcd
SHA256=$(SHA256_$(ARCH))
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)
CURL=curl -fSL --retry 3

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract build clean
get: download verify extract

link:
	@echo $(PACKAGE) $(VERSION)-$(RELEASE) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)

meta:
	curl --fail --silent --show-error "https://api.github.com/repos/$(REPONAME)/releases/tags/v$(VERSION)" | tee meta.json

download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

extract:
	mkdir -p $(PACKAGE)
	unzip -o $(FILENAME) -d $(PACKAGE)
	mv $(PACKAGE)/logcli-linux-$(ARCH) $(PACKAGE)/logcli.bin

clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	mkdir -p ../dist/rpm/
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	mkdir -p ../dist/deb/
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/

.NOTPARALLEL:

.PHONY: default all one get link meta download verify extract clean build rpm deb
