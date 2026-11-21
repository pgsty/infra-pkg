#==============================================================#
# File      :   Makefile
# Desc      :   Build the VictoriaMetrics RPM/DEB package group
# Path      :   victoria-metrics/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=VictoriaMetrics/VictoriaMetrics
PACKAGE=victoria-metrics
VERSION=1.156.0
RELEASE=1PGSTY
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
FILENAME1=victoria-metrics-linux-$(ARCH)-v$(VERSION).tar.gz
FILENAME2=victoria-metrics-linux-$(ARCH)-v$(VERSION)-cluster.tar.gz
FILENAME3=vmutils-linux-$(ARCH)-v$(VERSION).tar.gz
SHA2561_amd64=54409ea381db0316f0bf6f242c718bc498085eb1eb37520b73526e6d86891601
SHA2561_arm64=f777110b232bfdf435556c57d0896716e27000afafe969c4eb08852352dceb7d
SHA2561=$(SHA2561_$(ARCH))
SHA2562_amd64=e026eb6da6221c9058ad5ebeb8dda97106b2086b628d84c5c2b3d3ed8a7939d4
SHA2562_arm64=74505196bf58779c0b9eca0b6b469a9bdd5a8802b9dfc1ed1e40b71004992643
SHA2562=$(SHA2562_$(ARCH))
SHA2563_amd64=d71f7f00e07782531000620ec6c2a9d7ec83324f364dd1f36095ab378b5fb43b
SHA2563_arm64=1a8e4ed55df2a59d5cd03056213f50d293d4fab029e38dd960597362d92cf176
SHA2563=$(SHA2563_$(ARCH))
WEB_URL1=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME1)
WEB_URL2=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME2)
WEB_URL3=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME3)
CURL=curl -fSL --retry 3

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract build clean
get: download verify extract
link:
	@echo $(PACKAGE) package group $(VERSION)-$(RELEASE) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL1) -o $(FILENAME1)
	@echo $(CURL) $(WEB_URL2) -o $(FILENAME2)
	@echo $(CURL) $(WEB_URL3) -o $(FILENAME3)
meta:
	curl --fail --silent --show-error "https://api.github.com/repos/$(REPONAME)/releases/tags/v$(VERSION)" | tee meta.json
download:
	if [ -f ../tarball/$(FILENAME1) ]; then cp ../tarball/$(FILENAME1) .; else $(CURL) $(WEB_URL1) -o $(FILENAME1); fi
	if [ -f ../tarball/$(FILENAME2) ]; then cp ../tarball/$(FILENAME2) .; else $(CURL) $(WEB_URL2) -o $(FILENAME2); fi
	if [ -f ../tarball/$(FILENAME3) ]; then cp ../tarball/$(FILENAME3) .; else $(CURL) $(WEB_URL3) -o $(FILENAME3); fi
verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA2561)  $(FILENAME1)" | sha256sum -c -; else echo "$(SHA2561)  $(FILENAME1)" | shasum -a 256 -c -; fi
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA2562)  $(FILENAME2)" | sha256sum -c -; else echo "$(SHA2562)  $(FILENAME2)" | shasum -a 256 -c -; fi
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA2563)  $(FILENAME3)" | sha256sum -c -; else echo "$(SHA2563)  $(FILENAME3)" | shasum -a 256 -c -; fi
extract:
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME1) -C $(PACKAGE)
	tar -xf $(FILENAME2) -C $(PACKAGE)
	tar -xf $(FILENAME3) -C $(PACKAGE)
clean:
	rm -rf $(PACKAGE) $(FILENAME1) $(FILENAME2) $(FILENAME3) $(PACKAGE)*.rpm $(PACKAGE)*.deb
build: rpm deb
rpm:
	mkdir -p ../dist/rpm/
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
	../bin/nfpm package --config victoria-metrics-cluster.yaml --packager rpm --target ../dist/rpm/
	../bin/nfpm package --config vmutils.yaml --packager rpm --target ../dist/rpm/
deb:
	mkdir -p ../dist/deb/
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/
	../bin/nfpm package --config victoria-metrics-cluster.yaml --packager deb --target ../dist/deb/
	../bin/nfpm package --config vmutils.yaml --packager deb --target ../dist/deb/

.NOTPARALLEL:
.PHONY: default all one get link meta download verify extract clean build rpm deb
