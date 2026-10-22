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
VERSION=24.22.1
DIRNAME=node
FILENAME_amd64=node-v$(VERSION)-linux-x64.tar.xz
FILENAME_arm64=node-v$(VERSION)-linux-arm64.tar.xz
FILENAME=$(FILENAME_$(ARCH))
SHA256_amd64=6c172a9ab6718f7b801fb5a7bd486af2ee5e32758086a04b84fcce2aa77095e6
SHA256_arm64=dbabf7a1cbf947e6059ffad2c27b80041db97dea1e553b62afdee7f13fca336e
SHA256=$(SHA256_$(ARCH))
WEB_URL=https://nodejs.org/dist/v$(VERSION)/$(FILENAME)
CURL=curl -fSL --retry 3


default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract build clean
get: download verify extract

link:
	@echo $(PACKAGE) $(VERSION)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)

download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

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

.PHONY: all get link download verify extract clean build rpm deb one
