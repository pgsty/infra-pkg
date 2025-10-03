#==============================================================#
# File      :   Makefile
# Ctime     :   2024-07-25
# Mtime     :   2025-10-02
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME1=grafana/grafana-infinity-datasource
PACKAGE1=yesoreyeram-infinity-datasource
VERSION1=3.5.0
FILENAME1=yesoreyeram-infinity-datasource-$(VERSION1).linux_amd64.zip
WEB_URL1=https://github.com/$(REPONAME1)/releases/download/v$(VERSION1)/$(FILENAME1)

default: all
all: download extract build clean
get: download extract

# download latest release tarball to current directory
download:
	if [ -f ../tarball/$(FILENAME1) ]; then cp ../tarball/$(FILENAME1) .; else curl -SL $(WEB_URL1) -o $(FILENAME1); fi

# extract tarball content to current directory
extract:
	unzip $(FILENAME1)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE1) $(FILENAME1) $(PACKAGE1)*.rpm $(PACKAGE1)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	nfpm package --config nfpm.yaml --packager rpm --target ../../dist/rpm.x86_64/
deb:
	nfpm package --config nfpm.yaml --packager deb --target ../../dist/deb.amd64/


.PHONY: all get link meta download extract clean build rpm deb