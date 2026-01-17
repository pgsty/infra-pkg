#==============================================================#
# File      :   Makefile
# Ctime     :   2025-12-25
# Mtime     :   2026-01-16
# Desc      :   Makefile shortcuts for asciinema rpm/deb building
# Path      :   Makefile
# Copyright (C) 2018-2025 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME=asciinema/asciinema
PACKAGE=asciinema
VERSION=3.1.0
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/v$(VERSION)
FILENAME=$(PACKAGE)-aarch64-unknown-linux-gnu
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)

default: all
all: download build clean
get: download

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo curl -SL $(WEB_URL) -o $(FILENAME)

# get latest release info
meta:
	curl --silent "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

# download binary to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else curl -SL $(WEB_URL) -o $(FILENAME); fi
	chmod +x $(FILENAME)

# remove binary, rpm & deb files
clean:
	rm -rf $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	nfpm package --config asciinema.yaml --packager rpm --target ../../dist/rpm.aarch64/
deb:
	nfpm package --config asciinema.yaml --packager deb --target ../../dist/deb.arm64/


.PHONY: all get link meta download clean build rpm deb
