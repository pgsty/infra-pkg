#==============================================================#
# File      :   Makefile
# Ctime     :   2025-01-08
# Mtime     :   2026-01-16
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2025 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME="NpgsqlRest/NpgsqlRest"
PACKAGE="npgsqlrest"
VERSION=3.4.3
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/v$(VERSION)
FILENAME="$(PACKAGE)-linux-arm64"
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)


default: all
all: download extract build clean
get: download extract

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo curl -SL $(WEB_URL) -o $(FILENAME)

# get latest release info
meta:
	curl --silent "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

# download latest release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else curl -SL $(WEB_URL) -o $(FILENAME); fi

# extract tarball content to current directory
extract:
	mkdir -p $(PACKAGE)
	cp $(FILENAME) $(PACKAGE)/$(PACKAGE)
	chmod +x $(PACKAGE)/$(PACKAGE)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	nfpm package --config nfpm-rpm.yaml --packager rpm --target ../../dist/rpm.aarch64/
deb:
	nfpm package --config nfpm-deb.yaml --packager deb --target ../../dist/deb.arm64/


.PHONY: all get link meta download extract clean build rpm deb
