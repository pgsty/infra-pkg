#==============================================================#
# File      :   Makefile
# Ctime     :   2026-02-22
# Mtime     :   2026-02-22
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME=stalwartlabs/stalwart
PACKAGE=stalwart
VERSION=0.15.5
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
FILENAME1=$(PACKAGE)-x86_64-unknown-linux-musl.tar.gz
FILENAME2=$(PACKAGE)-cli-x86_64-unknown-linux-musl.tar.gz
WEB_URL1=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME1)
WEB_URL2=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME2)


default: all
all: download extract build clean
get: download extract

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo curl -SL $(WEB_URL1) -o $(FILENAME1)
	@echo curl -SL $(WEB_URL2) -o $(FILENAME2)

# get latest release info
meta:
	curl --silent "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

# download latest release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME1) ]; then cp ../tarball/$(FILENAME1) .; else curl -SL $(WEB_URL1) -o $(FILENAME1); fi
	if [ -f ../tarball/$(FILENAME2) ]; then cp ../tarball/$(FILENAME2) .; else curl -SL $(WEB_URL2) -o $(FILENAME2); fi

# extract tarball content to current directory
extract:
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME1) -C $(PACKAGE)
	tar -xf $(FILENAME2) -C $(PACKAGE)
	chmod +x $(PACKAGE)/stalwart $(PACKAGE)/stalwart-cli

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME1) $(FILENAME2) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	nfpm package --config nfpm.yaml --packager rpm --target ../../dist/rpm.x86_64/
deb:
	nfpm package --config nfpm.yaml --packager deb --target ../../dist/deb.amd64/


.PHONY: all get link meta download extract clean build rpm deb
