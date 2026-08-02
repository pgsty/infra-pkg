#==============================================================#
# File      :   Makefile
# Ctime     :   2024-07-25
# Mtime     :   2026-04-15
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#
PACKAGE=plugins
VERSION=13.0.0
DIRNAME=$(PACKAGE)-v$(VERSION).linux-amd64
FILENAME=plugins-$(VERSION).tar.gz
SHA256=3a4bfcbe1ea23ec5a1f3ceba35471c48d496fbfda451c55a65665a2b81193f86
FILENAME2=chart.tgz
SHA2562=b3aa73759d1890dd5be9e9527423ef1e92c76076f2aeb5476d5a6dbf7ecbc825
WEB_URL2=https://repo.pigsty.io/etc/$(FILENAME2)


default: all
all: download verify extract build clean
get: download verify extract

# print input commands
link:
	@echo cp ../tarball/$(FILENAME) $(FILENAME)
	@echo curl -fSL $(WEB_URL2) -o $(FILENAME2)


# copy the manually consolidated plugin bundle and fetch the auxiliary assets
download:
	cp ../tarball/$(FILENAME) .
	if [ -f ../tarball/$(FILENAME2) ]; then cp ../tarball/$(FILENAME2) .; else curl -fSL $(WEB_URL2) -o $(FILENAME2); fi

# verify cached or downloaded inputs before extraction
verify:
	if command -v sha256sum >/dev/null 2>&1; then printf '%s  %s\n%s  %s\n' "$(SHA256)" "$(FILENAME)" "$(SHA2562)" "$(FILENAME2)" | sha256sum -c -; else printf '%s  %s\n%s  %s\n' "$(SHA256)" "$(FILENAME)" "$(SHA2562)" "$(FILENAME2)" | shasum -a 256 -c -; fi

# extract tarball content to current directory
extract:
	tar -xf $(FILENAME) 
	tar -xf $(FILENAME2)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb chart.tgz chart

# build rpm & deb package
build: rpm deb
rpm:
	../../bin/nfpm package --config nfpm.yaml --packager rpm --target ../../dist/noarch/
deb:
	../../bin/nfpm package --config nfpm.yaml --packager deb --target ../../dist/noarch/


.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb
