#==============================================================#
# File      :   Makefile
# Ctime     :   2024-12-14
# Mtime     :   2025-02-24
# Desc      :   Makefile shortcuts for pkg building
# Path      :   Makefile
# Copyright (C) 2018-2023 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME=v2fly/v2ray-core
PACKAGE=v2ray
VERSION=5.28.0
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/v$(VERSION)
DIRNAME=$(PACKAGE)-linux-64
FILENAME=$(DIRNAME).zip
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)



default: all
all: clean download extract build clean
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
	mkdir -p v2ray
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) v2ray/; else curl -SL $(WEB_URL) -o $(FILENAME); fi

# extract tarball content to current directory
extract:
	@echo $(FILENAME)
	cd v2ray && unzip $(FILENAME)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	nfpm package --config v2ray-rpm.yaml --packager rpm --target ../../dist/rpm.x86_64/
deb:
	nfpm package --config v2ray-deb.yaml --packager deb --target ../../dist/deb.amd64/


.PHONY: all get link meta download extract clean build rpm deb