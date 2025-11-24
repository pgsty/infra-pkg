#==============================================================#
# File      :   Makefile
# Ctime     :   2024-07-25
# Mtime     :   2025-11-24
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#
PACKAGE=plugins
VERSION=12.3.0
DIRNAME=$(PACKAGE)-v$(VERSION).linux-amd64
FILENAME=plugins-$(VERSION).tar.gz
WEB_URL=https://repo.pigsty.io/etc/$(FILENAME)
FILENAME2=chart.tgz
WEB_URL=https://repo.pigsty.io/etc/$(FILENAME)


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
	if [ -f ../tarball/$(FILENAME2) ]; then cp ../tarball/$(FILENAME2) .; else curl -SL $(WEB_URL2) -o $(FILENAME2); fi

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
	nfpm package --config nfpm.yaml --packager rpm --target ../../dist/noarch/
deb:
	nfpm package --config nfpm.yaml --packager deb --target ../../dist/noarch/


.PHONY: all get link meta download extract clean build rpm deb