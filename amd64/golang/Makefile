#==============================================================#
# File      :   Makefile
# Ctime     :   2025-01-05
# Mtime     :   2026-01-16
# Desc      :   Makefile shortcuts for golang rpm/deb building
# Path      :   amd64/golang/Makefile
# Copyright (C) 2018-2025 Ruohang Feng (rh@vonng.com)
#==============================================================#
PACKAGE=golang
VERSION=1.25.6
DIRNAME=go
FILENAME=go$(VERSION).linux-amd64.tar.gz
WEB_URL=https://go.dev/dl/$(FILENAME)


default: all
all: download extract build clean
get: download extract

link:
	@echo $(PACKAGE) $(VERSION)
	@echo curl -SL $(WEB_URL) -o $(FILENAME)

download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else curl -SL $(WEB_URL) -o $(FILENAME); fi

extract:
	tar -xf $(FILENAME)

clean:
	rm -rf $(DIRNAME) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	nfpm package --config nfpm.yaml --packager rpm --target ../../dist/rpm.x86_64/
deb:
	nfpm package --config nfpm.yaml --packager deb --target ../../dist/deb.amd64/


.PHONY: all get link download extract clean build rpm deb
