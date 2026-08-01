#==============================================================#
# File      :   Makefile
# Ctime     :   2023-10-05
# Mtime     :   2026-08-01
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2023 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME="mehdy/keepalived-exporter"
PACKAGE="keepalived-exporter"
VERSION=1.7.1
SHA256=2adb1dd62a50cd98f723eab28244420868dee1dae2a9d2dcd0a5f1ed647a5f59
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
DIRNAME="$(PACKAGE)_$(VERSION)_linux_amd64"
FILENAME="$(DIRNAME).tar.gz"
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)

default: all
all: download extract build clean
get: download extract

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo curl -fSL --retry 3 $(WEB_URL) -o $(FILENAME)

# get latest release info
meta:
	curl --fail --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

# download latest release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	@echo $(WEB_URL)
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else curl -fSL --retry 3 $(WEB_URL) -o $(FILENAME); fi
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

# extract tarball content to current directory
extract:
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME)  -C $(PACKAGE) # --strip-components 1

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../../bin/nfpm package --config nfpm.yaml --packager rpm --target ../../dist/rpm.x86_64/
deb:
	../../bin/nfpm package --config nfpm.yaml --packager deb --target ../../dist/deb.amd64/


.NOTPARALLEL:

.PHONY: all get link meta download extract clean build rpm deb
