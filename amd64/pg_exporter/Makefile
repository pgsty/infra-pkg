#==============================================================#
# File      :   Makefile
# Ctime     :   2026-07-20
# Mtime     :   2026-07-20
# Desc      :   Makefile shortcuts for pg-exporter rpm/deb build
# Path      :   amd64/pg_exporter/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME=pgsty/pg_exporter
PACKAGE=pg_exporter
VERSION=1.4.0
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
FILENAME=$(PACKAGE)-$(VERSION).linux-amd64.tar.gz
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)
SHA256=113dfe70d4f780a456c05ca6b731f96c1013bf35ecb87d75c443fe2bac7e333b
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
	curl --silent "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

# copy versioned tarball from the shared cache, or fetch it from upstream
download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

# validate the pinned upstream archive before packaging
verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi
	tar -tzf $(FILENAME) >/dev/null

# extract the flat release tarball into the package build directory
extract:
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME) -C $(PACKAGE)

# remove copied inputs and temporary build directory
clean:
	rm -rf $(PACKAGE) $(FILENAME) pg-exporter*.rpm pg-exporter*.deb

# build rpm & deb package
build: rpm deb
rpm:
	nfpm package --config nfpm-rpm.yaml --packager rpm --target ../../dist/rpm.x86_64/
deb:
	nfpm package --config nfpm-deb.yaml --packager deb --target ../../dist/deb.amd64/


.PHONY: all get link meta download verify extract clean build rpm deb
