#==============================================================#
# File      :   Makefile
# Ctime     :   2024-07-25
# Mtime     :   2026-01-16
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME2=VictoriaMetrics/victoriametrics-datasource
PACKAGE2=victoriametrics-metrics-datasource
VERSION2=1.0.1
PROXY ?= http://127.0.0.1:8888
CURL=curl --proxy "$(PROXY)" -fSL --retry 3
FILENAME2=$(PACKAGE2)-v$(VERSION2).tar.gz
WEB_URL2=https://github.com/$(REPONAME2)/releases/download/v$(VERSION2)/$(FILENAME2)
SHA2562=68cce244b30e36528bf3782014ad8c241cc2ee8e2c2def318a20139390ad4f55

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract build clean
get: download verify extract

# print download link and download command
link:
	@echo $(CURL) $(WEB_URL2) -o $(FILENAME2)

# download latest release tarball to current directory
download:
	if [ -f ../tarball/$(FILENAME2) ]; then cp ../tarball/$(FILENAME2) .; else $(CURL) $(WEB_URL2) -o $(FILENAME2); fi

# verify cached or downloaded input before extraction
verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA2562)  $(FILENAME2)" | sha256sum -c -; else echo "$(SHA2562)  $(FILENAME2)" | shasum -a 256 -c -; fi

# extract tarball content to current directory
extract:
	tar -xf $(FILENAME2)
	python3 prepare.py $(PACKAGE2) $(VERSION2) $(ARCH)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE2) $(FILENAME2) $(PACKAGE2)*.rpm $(PACKAGE2)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/

test:
	PYTHONDONTWRITEBYTECODE=1 python3 -m unittest -v test_prepare.py

.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb one test
