#==============================================================#
# File      :   Makefile
# Ctime     :   2023-10-05
# Mtime     :   2025-03-21
# Desc      :   Makefile shortcuts for rpm/deb building
# Path      :   Makefile
# Copyright (C) 2018-2023 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME="kafka"
PACKAGE="kafka"
VERSION=4.0.0
RELEASE_PAGE=https://downloads.apache.org/kafka/$(VERSION)/kafka_2.13-$(VERSION).tgz
DIRNAME="kafka_2.13-$(VERSION)"
FILENAME="$(DIRNAME).tgz"
WEB_URL=https://downloads.apache.org/kafka/$(VERSION)/kafka_2.13-$(VERSION).tgz


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
	tar -xf $(FILENAME) --strip-components 1 -C $(PACKAGE)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	nfpm package --config nfpm-rpm.yaml --packager rpm --target ../../dist/rpm.x86_64/
deb:
	nfpm package --config nfpm-deb.yaml --packager deb --target ../../dist/deb.amd64/


.PHONY: all get link meta download extract clean build rpm deb