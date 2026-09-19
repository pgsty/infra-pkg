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
VERSION=1.152.0
RELEASE=1PGSTY
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
FILENAME1=victoria-metrics-linux-$(ARCH)-v$(VERSION).tar.gz
FILENAME2=victoria-metrics-linux-$(ARCH)-v$(VERSION)-cluster.tar.gz
FILENAME3=vmutils-linux-$(ARCH)-v$(VERSION).tar.gz
SHA2561_amd64=1be2fc4bbdbfa56ba0480e6b0aff736f0c17e5e5b8b888587b69c3a21b42114a
SHA2561_arm64=2d09ef656cce7f6b5b7252ff2eb7e5325ee996100fcd562a18eb89693c6344ef
SHA2561=$(SHA2561_$(ARCH))
SHA2562_amd64=631fe9d51c2d124a3c8c90e58793e74d308c4a2a3d16a494c0c82ad550a80d48
SHA2562_arm64=c2627b145a3089085f8d4cd518309c565c1705a9832f085cca1582529eace2dd
SHA2562=$(SHA2562_$(ARCH))
SHA2563_amd64=8eee4a98ff1665c60682475e8a8b292b8d718b63a2f023124384dd2f6a220c79
SHA2563_arm64=57c567b262962a4cb8e35c0c34efe64629a3e1ea69ac0611d8d67e168df8b1e8
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
