#==============================================================#
# File      :   Makefile
# Ctime     :   2025-12-04
# Mtime     :   2026-08-02
# Desc      :   Makefile shortcuts for rustfs rpm/deb build
# Path      :   amd64/rustfs/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME=rustfs/rustfs
PACKAGE=rustfs
VERSION=1.0.0-beta.12
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/$(VERSION)
FILENAME=$(PACKAGE)-linux-x86_64-musl-v$(VERSION).zip
WEB_URL=https://github.com/$(REPONAME)/releases/download/$(VERSION)/$(FILENAME)
SHA256=683bef16247ab04bedb76d0444736f286d21943375d2d57d2ded9ec277498427
CURL=curl -fSL --retry 3

default: all
all: download verify extract build clean
get: download verify extract

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)

# get latest release info
meta:
	curl --fail --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/tags/$(VERSION)" | tee meta.json

# download latest release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

# validate the pinned upstream archive before extraction
verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

# extract zip content to current directory
extract:
	mkdir -p $(PACKAGE)
	unzip -o $(FILENAME) -d $(PACKAGE)
	chmod +x $(PACKAGE)/rustfs

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../../bin/nfpm package --config nfpm.yaml --packager rpm --target ../../dist/rpm.x86_64/
deb:
	../../bin/nfpm package --config nfpm.yaml --packager deb --target ../../dist/deb.amd64/


.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb
