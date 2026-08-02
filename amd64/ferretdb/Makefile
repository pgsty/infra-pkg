#==============================================================#
# File      :   Makefile
# Ctime     :   2024-07-25
# Mtime     :   2025-07-24
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME=FerretDB/FerretDB
PACKAGE=ferretdb
VERSION=2.7.0
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
FILENAME=$(PACKAGE)-amd64-linux
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)
SHA256=f81ecae6adf33e0c5e949acf85f94a40b0790c07b8f87d480b91518225da26b4

default: all
all: download verify extract build clean
get: download verify extract

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo curl -fSL $(WEB_URL) -o $(FILENAME)

# get latest release info
meta:
	curl --fail --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

# download configured release binary to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else curl -fSL $(WEB_URL) -o $(FILENAME); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

# confirm downloaded binary is present
extract:
	ls $(FILENAME)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../../bin/nfpm package --config ferretdb.yaml --packager rpm --target ../../dist/rpm.x86_64/
deb:
	../../bin/nfpm package --config ferretdb.yaml --packager deb --target ../../dist/deb.amd64/


.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb
