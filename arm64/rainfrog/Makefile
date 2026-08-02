#==============================================================#
# File      :   Makefile
# Ctime     :   2026-03-21
# Mtime     :   2026-03-21
# Desc      :   Makefile shortcuts for rainfrog rpm/deb building
# Path      :   Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME=achristmascarl/rainfrog
PACKAGE=rainfrog
VERSION=0.4.2
TAG=v$(VERSION)
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/$(TAG)
TARGET=aarch64-unknown-linux-musl
FILENAME=$(PACKAGE)-v$(VERSION)-$(TARGET).tar.gz
SHA256=967a4adb1cdd6f551d1dc89fa4f8b57d160bee8a1687a1f86be445f64cf047de
WEB_URL=https://github.com/$(REPONAME)/releases/download/$(TAG)/$(FILENAME)
CURL=curl --http1.1 --retry 5 --retry-delay 2 --retry-connrefused --continue-at - -fL

default: all
all: download verify extract build clean
get: download verify extract

link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)

meta:
	curl --fail --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

extract:
	rm -rf $(PACKAGE)
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME) -C $(PACKAGE)
	chmod +x $(PACKAGE)/$(PACKAGE)

clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	../../bin/nfpm package --config nfpm.yaml --packager rpm --target ../../dist/rpm.aarch64/
deb:
	../../bin/nfpm package --config nfpm.yaml --packager deb --target ../../dist/deb.arm64/


.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb
