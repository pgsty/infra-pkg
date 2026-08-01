#==============================================================#
# File      :   Makefile
# Ctime     :   2024-12-14
# Mtime     :   2026-08-02
# Desc      :   Makefile shortcuts for v2ray rpm/deb build
# Path      :   arm64/v2ray/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME=v2fly/v2ray-core
PACKAGE=v2ray
VERSION=5.51.2
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
DIRNAME=$(PACKAGE)-linux-arm64-v8a
FILENAME=$(DIRNAME).zip
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)
SHA256=0fd8a6cee265e2245b7aff460176056f9777b2e47d5b0680e3e635d827340485
CURL=curl -fSL --retry 3



default: all
all:
	$(MAKE) clean
	$(MAKE) download
	$(MAKE) verify
	$(MAKE) extract
	$(MAKE) build
	$(MAKE) clean
get:
	$(MAKE) download
	$(MAKE) verify
	$(MAKE) extract

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)

# get latest release info
meta:
	curl --fail --silent --show-error "https://api.github.com/repos/$(REPONAME)/releases/tags/v$(VERSION)" | tee meta.json

# download latest release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	mkdir -p $(PACKAGE)
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) $(PACKAGE)/; else $(CURL) $(WEB_URL) -o $(PACKAGE)/$(FILENAME); fi

# validate the pinned upstream archive before extraction
verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(PACKAGE)/$(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(PACKAGE)/$(FILENAME)" | shasum -a 256 -c -; fi

# extract tarball content to current directory
extract:
	@echo $(FILENAME)
	cd $(PACKAGE) && unzip -o $(FILENAME)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../../bin/nfpm package --config nfpm.yaml --packager rpm --target ../../dist/rpm.aarch64/
deb:
	../../bin/nfpm package --config nfpm.yaml --packager deb --target ../../dist/deb.arm64/

.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb
