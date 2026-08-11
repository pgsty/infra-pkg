#==============================================================#
# File      :   Makefile
# Ctime     :   2024-07-25
# Mtime     :   2025-10-02
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME1=grafana/grafana-infinity-datasource
PACKAGE1=yesoreyeram-infinity-datasource
VERSION1=3.11.3
FILENAME1=yesoreyeram-infinity-datasource-$(VERSION1).linux_$(ARCH).zip
WEB_URL1=https://github.com/$(REPONAME1)/releases/download/v$(VERSION1)/$(FILENAME1)
SHA2561_amd64=c734c6773bc92989d2a99f007e34d4db00e5a5efcd347b45e5fefb1d829ca1ee
SHA2561_arm64=e8cd0c6f82644de90e1de87d3df36707f4946fbd1809a2ec238c4994cacb8ff4
SHA2561=$(SHA2561_$(ARCH))

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract build clean
get: download verify extract

# print download link and download command
link:
	@echo curl -fSL --retry 3 $(WEB_URL1) -o $(FILENAME1)

# download latest release tarball to current directory
download:
	if [ -f ../tarball/$(FILENAME1) ]; then cp ../tarball/$(FILENAME1) .; else curl -fSL --retry 3 $(WEB_URL1) -o $(FILENAME1); fi

# verify cached or downloaded input before extraction
verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA2561)  $(FILENAME1)" | sha256sum -c -; else echo "$(SHA2561)  $(FILENAME1)" | shasum -a 256 -c -; fi

# extract tarball content to current directory
extract:
	unzip $(FILENAME1)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE1) $(FILENAME1) $(PACKAGE1)*.rpm $(PACKAGE1)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/

.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb one
