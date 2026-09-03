#==============================================================#
# File      :   Makefile
# Ctime     :   2026-08-30
# Mtime     :   2026-09-01
# Desc      :   Tailcat RPM/DEB package from official archives
# Path      :   tailcat/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=tailscale/tailcat
PACKAGE=tailcat
VERSION=0.4.0
RELEASE=1PGSTY
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
FILENAME=$(PACKAGE)_$(VERSION)_linux_$(ARCH).tar.gz
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)
SHA256_amd64=8b819c43dfdf806b5663e23535aba557bb106075b0b5839df289af9bba70bec2
SHA256_arm64=3b77322350f64d229d5b2119b159b863b4bcffa0a62a0294682423a19956dc76
SHA256=$(SHA256_$(ARCH))
SOURCE=source
STAGE=stage
PROXY ?= http://127.0.0.1:8118
PROXY_ARG=$(if $(strip $(PROXY)),--proxy $(PROXY),)
CURL=curl --http1.1 --retry 5 --retry-delay 2 --retry-connrefused --continue-at - $(PROXY_ARG) -fL

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract build clean
get: download verify extract

link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)

download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

verify:
	@if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi
	tar -tzf $(FILENAME) >/dev/null

extract:
	rm -rf $(SOURCE) $(STAGE)
	mkdir -p $(SOURCE) $(STAGE)/usr/bin $(STAGE)/usr/share/doc/$(PACKAGE)
	tar -xf $(FILENAME) -C $(SOURCE)
	cp $(SOURCE)/$(PACKAGE) $(STAGE)/usr/bin/$(PACKAGE)
	cp $(SOURCE)/LICENSE $(STAGE)/usr/share/doc/$(PACKAGE)/LICENSE
	chmod 0755 $(STAGE)/usr/bin/$(PACKAGE)

clean:
	rm -rf $(SOURCE) $(STAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/

.NOTPARALLEL:

.PHONY: default all one get link download verify extract clean build rpm deb
