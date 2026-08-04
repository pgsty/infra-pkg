#==============================================================#
# File      :   Makefile
# Ctime     :   2024-07-25
# Mtime     :   2026-02-26
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#
VERSION=1.23.0
ASSET=index.html
FILENAME=pev2-$(VERSION).html
SHA256=82b1577a4922050c9e12ebcc0bcfc69ba7e6dfcd0ecef19e88d31b1627d06a29
WEB_URL=https://github.com/dalibo/pev2/releases/download/v$(VERSION)/$(ASSET)

default: all
all: download verify extract build clean
get: download verify extract

# print download link and download command
link:
	@echo curl -fSL $(WEB_URL) -o $(FILENAME)


# download latest release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else curl -fSL $(WEB_URL) -o $(FILENAME); fi

# verify and prepare the release HTML
verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

extract:
	mv $(FILENAME) pev2.html

# remove downloaded and prepared files
clean:
	rm -rf pev2.html $(FILENAME)

# build rpm & deb package
build: rpm deb
rpm:
	mkdir -p ../../dist/noarch/
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	mkdir -p ../../dist/noarch/
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb
