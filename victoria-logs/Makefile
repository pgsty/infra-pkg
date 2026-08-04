#==============================================================#
# File      :   Makefile
# Ctime     :   2025-07-16
# Mtime     :   2025-12-05
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2023 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=VictoriaMetrics/VictoriaLogs
PACKAGE=victoria-logs
VERSION=1.52.0
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
FILENAME1=victoria-logs-linux-$(ARCH)-v$(VERSION).tar.gz
FILENAME2=vlutils-linux-$(ARCH)-v$(VERSION).tar.gz
SHA2561_amd64=d14f585144b8d6813f15e11f0041f487e15e10e5f5e5a31be0311367e93d3494
SHA2561_arm64=91338c3e5e3d743a862c0a8665bf80862f639dbd4de6f6ff19ada7df5e9acf45
SHA2561=$(SHA2561_$(ARCH))
SHA2562_amd64=caa315764df0d11a77ba61d4ee96b783ddb98455b167da8326940dda62914bc9
SHA2562_arm64=82c776d2cd58410aff63c95a36f398b7d50c2e178566bcaa56996dfdfccff794
SHA2562=$(SHA2562_$(ARCH))
WEB_URL1=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME1)
WEB_URL2=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME2)


default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract build clean
get: download verify extract

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo curl -fSL $(WEB_URL1) -o $(FILENAME1)
	@echo curl -fSL $(WEB_URL2) -o $(FILENAME2)

# get latest release info
meta:
	curl --fail --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

# download configured release tarballs to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME1) ]; then cp ../tarball/$(FILENAME1) .; else curl -fSL $(WEB_URL1) -o $(FILENAME1); fi
	if [ -f ../tarball/$(FILENAME2) ]; then cp ../tarball/$(FILENAME2) .; else curl -fSL $(WEB_URL2) -o $(FILENAME2); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA2561)  $(FILENAME1)" | sha256sum -c -; else echo "$(SHA2561)  $(FILENAME1)" | shasum -a 256 -c -; fi
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA2562)  $(FILENAME2)" | sha256sum -c -; else echo "$(SHA2562)  $(FILENAME2)" | shasum -a 256 -c -; fi

# extract tarball content to current directory
extract:
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME1)  -C $(PACKAGE)
	tar -xf $(FILENAME2)  -C $(PACKAGE)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME1) $(FILENAME2)

# build rpm & deb package
build: rpm deb
rpm:
	../bin/nfpm package --config victoria-logs.yaml  --packager rpm --target ../dist/rpm/
	../bin/nfpm package --config vlogscli.yaml       --packager rpm --target ../dist/rpm/
	../bin/nfpm package --config vlagent.yaml        --packager rpm --target ../dist/rpm/

deb:
	../bin/nfpm package --config victoria-logs.yaml  --packager deb --target ../dist/deb/
	../bin/nfpm package --config vlogscli.yaml       --packager deb --target ../dist/deb/
	../bin/nfpm package --config vlagent.yaml        --packager deb --target ../dist/deb/

.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb one
