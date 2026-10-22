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
VERSION=1.154.1
RELEASE=1PGSTY
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
FILENAME1=victoria-metrics-linux-$(ARCH)-v$(VERSION).tar.gz
FILENAME2=victoria-metrics-linux-$(ARCH)-v$(VERSION)-cluster.tar.gz
FILENAME3=vmutils-linux-$(ARCH)-v$(VERSION).tar.gz
SHA2561_amd64=8c40aec9f77be3a85fbe4b491238b80936af50497fef980b9434095d5076e424
SHA2561_arm64=9bbc27a62e7f16fbe4bf995c5c4975fcbdd5e856e302e9ec833eb963ce097d11
SHA2561=$(SHA2561_$(ARCH))
SHA2562_amd64=590b16248260b7b703e042e020cfe62bdeff76f77c8b7fd69c603cb66ae0d8d2
SHA2562_arm64=08dabda8f9529c52b663ce18ef7cc86a19195834f48fe1d26c3c866676ad5245
SHA2562=$(SHA2562_$(ARCH))
SHA2563_amd64=989c8f73edc5d131eb169bb689d7b77bb1d31b14314159c7f6bbae38ba655938
SHA2563_arm64=e9a44e352da8200d427815acab179850cef0a13ed4d0e5ef95a7f1e46c81b0aa
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
