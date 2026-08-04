#==============================================================#
# File      :   Makefile
# Ctime     :   2025-01-05
# Mtime     :   2025-01-05
# Desc      :   Makefile shortcuts for nodejs rpm/deb building
# Path      :   nodejs/Makefile
# Copyright (C) 2018-2025 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

PACKAGE=nodejs
VERSION=24.18.1
DIRNAME=node
FILENAME_amd64=node-v$(VERSION)-linux-x64.tar.xz
FILENAME_arm64=node-v$(VERSION)-linux-arm64.tar.xz
FILENAME=$(FILENAME_$(ARCH))
WEB_URL=https://nodejs.org/dist/v$(VERSION)/$(FILENAME)


default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download extract build clean
get: download extract

link:
	@echo $(PACKAGE) $(VERSION)
	@echo curl -fSL $(WEB_URL) -o $(FILENAME)

download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else curl -fSL $(WEB_URL) -o $(FILENAME); fi

extract:
	mkdir -p $(DIRNAME)
	tar -xf $(FILENAME) --strip-components 1 -C $(DIRNAME)

clean:
	rm -rf $(DIRNAME) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link download extract clean build rpm deb one
