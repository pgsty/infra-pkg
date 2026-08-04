#==============================================================#
# File      :   Makefile
# Ctime     :   2023-10-05
# Mtime     :   2026-08-02
# Desc      :   Makefile shortcuts for Kafka rpm/deb build
# Path      :   kafka/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME=kafka
PACKAGE=kafka
VERSION=4.3.1
RELEASE_PAGE=https://downloads.apache.org/kafka/$(VERSION)/
DIRNAME=kafka_2.13-$(VERSION)
FILENAME=$(DIRNAME).tgz
WEB_URL=$(RELEASE_PAGE)$(FILENAME)
SHA512=c7d7b2318cb51aa0c61d3246a51c349210073c5c9b754947ef965a439f2f939e8600f204e134a75ac31faf3829c9370960ef7c6a9886c8a1dbf0339a21f4c54c
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
	curl --fail --silent --show-error https://kafka.apache.org/community/downloads/ | tee meta.html

# download latest release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

# validate the pinned upstream archive before extraction
verify:
	if command -v sha512sum >/dev/null 2>&1; then echo "$(SHA512)  $(FILENAME)" | sha512sum -c -; else echo "$(SHA512)  $(FILENAME)" | shasum -a 512 -c -; fi

# extract tarball content to current directory
extract:
	rm -rf $(PACKAGE)
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME) --strip-components 1 -C $(PACKAGE)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb
