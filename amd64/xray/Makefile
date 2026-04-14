#==============================================================#
# File      :   Makefile
# Ctime     :   2026-03-05
# Mtime     :   2026-03-05
# Desc      :   Makefile shortcuts for pkg building
# Path      :   Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME=XTLS/Xray-core
PACKAGE=xray
VERSION=26.3.27
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
DIRNAME=Xray-linux-64
FILENAME=$(DIRNAME).zip
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)



default: all
all:
	$(MAKE) clean
	$(MAKE) download
	$(MAKE) extract
	$(MAKE) build
	$(MAKE) clean
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
	mkdir -p $(PACKAGE)
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) $(PACKAGE)/; else curl -SL $(WEB_URL) -o $(PACKAGE)/$(FILENAME); fi

# extract tarball content to current directory
extract:
	@echo $(FILENAME)
	cd $(PACKAGE) && unzip $(FILENAME)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	nfpm package --config xray-rpm.yaml --packager rpm --target ../../dist/rpm.x86_64/
deb:
	nfpm package --config xray-deb.yaml --packager deb --target ../../dist/deb.amd64/


.PHONY: all get link meta download extract clean build rpm deb
