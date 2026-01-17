#==============================================================#
# File      :   Makefile
# Ctime     :   2024-07-25
# Mtime     :   2026-01-16
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#
VERSION=1.20.0
FILENAME=index.html
WEB_URL=https://github.com/dalibo/pev2/releases/download/v$(VERSION)/$(FILENAME)

default: all
all: download extract build clean
get: download extract

# print download link and download command
link:
	@echo curl -SL $(WEB_URL) -o $(FILENAME)


# download latest release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else curl -SL $(WEB_URL) -o $(FILENAME); fi

# extract tarball content to current directory
extract:
	mv index.html pev2.html

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf pev2.html index.html

# build rpm & deb package
build: rpm deb
rpm:
	mkdir -p ../../dist/noarch/
	nfpm package --config nfpm.yaml --packager rpm --target ../../dist/noarch/
deb:
	mkdir -p ../../dist/noarch/
	nfpm package --config nfpm.yaml --packager deb --target ../../dist/noarch/


.PHONY: all get link meta download extract clean build rpm deb