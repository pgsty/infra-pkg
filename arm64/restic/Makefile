#==============================================================#
# File      :   Makefile
# Ctime     :   2025-03-17
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2023 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME="restic/restic"
PACKAGE="restic"
VERSION=0.17.3
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/v$(VERSION)
DIRNAME="$(PACKAGE)"
FILENAME="$(PACKAGE)_$(VERSION)_linux_arm64.bz2"
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

# extract bz2 content to current directory
extract:
	bunzip2 $(FILENAME) && mv $(PACKAGE)_$(VERSION)_linux_arm64 $(PACKAGE)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	nfpm package --config nfpm.yaml --packager rpm --target ../../dist/rpm.aarch64/
deb:
	nfpm package --config nfpm.yaml --packager deb --target ../../dist/deb.arm64/


.PHONY: all get link meta download extract clean build rpm deb 