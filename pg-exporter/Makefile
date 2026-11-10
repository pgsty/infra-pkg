#==============================================================#
# File      :   Makefile
# Ctime     :   2026-07-20
# Mtime     :   2026-08-02
# Desc      :   Makefile shortcuts for pg-exporter rpm/deb build
# Path      :   pg-exporter/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=pgsty/pg_exporter
PACKAGE=pg_exporter
VERSION=1.6.0
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
FILENAME=$(PACKAGE)-$(VERSION).linux-$(ARCH).tar.gz
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)
SHA256_amd64=296a26bf83acd7024f4de8fdeac0ee31baffa01e3153cf5c694e90ed8268719a
SHA256_arm64=ea6d1dbe0820d599e81ed702e128b4fe4a557e2afb5b5c157de222576c1d7ce7
SHA256=$(SHA256_$(ARCH))
PROXY ?= http://127.0.0.1:8888
CURL=curl --proxy "$(PROXY)" -fSL --retry 3


default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract build clean
get: download verify extract

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)

# get latest release info
meta:
	$(CURL) --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

# copy versioned tarball from the shared cache, or fetch it from upstream
download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

# validate the pinned upstream archive before packaging
verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi
	tar -tzf $(FILENAME) >/dev/null

# extract the flat release tarball into the package build directory
extract:
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME) -C $(PACKAGE)

# remove copied inputs and temporary build directory
clean:
	rm -rf $(PACKAGE) $(FILENAME) pg-exporter*.rpm pg-exporter*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb one
