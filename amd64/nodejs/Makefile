#==============================================================#
# File      :   Makefile
# Ctime     :   2025-01-05
# Mtime     :   2025-01-05
# Desc      :   Makefile shortcuts for nodejs rpm/deb building
# Path      :   amd64/nodejs/Makefile
# Copyright (C) 2018-2025 Ruohang Feng (rh@vonng.com)
#==============================================================#
PACKAGE=nodejs
VERSION=24.12.0
DIRNAME=node
FILENAME=node-v$(VERSION)-linux-x64.tar.xz
WEB_URL=https://nodejs.org/dist/v$(VERSION)/$(FILENAME)


default: all
all: download extract build clean
get: download extract

link:
	@echo $(PACKAGE) $(VERSION)
	@echo curl -SL $(WEB_URL) -o $(FILENAME)

download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else curl -SL $(WEB_URL) -o $(FILENAME); fi

extract:
	mkdir -p $(DIRNAME)
	tar -xf $(FILENAME) --strip-components 1 -C $(DIRNAME)

clean:
	rm -rf $(DIRNAME) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	nfpm package --config nfpm.yaml --packager rpm --target ../../dist/rpm.x86_64/
deb:
	nfpm package --config nfpm.yaml --packager deb --target ../../dist/deb.amd64/


.PHONY: all get link download extract clean build rpm deb
