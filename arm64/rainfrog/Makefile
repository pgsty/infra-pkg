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
VERSION=0.3.17
TAG=v$(VERSION)
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/$(TAG)
TARGET=aarch64-unknown-linux-musl
FILENAME=$(PACKAGE)-v$(VERSION)-$(TARGET).tar.gz
WEB_URL=https://github.com/$(REPONAME)/releases/download/$(TAG)/$(FILENAME)
CURL=curl --http1.1 --retry 5 --retry-delay 2 --retry-connrefused --continue-at - -fL

default: all
all: download extract build clean
get: download extract

link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)

meta:
	curl --silent "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

extract:
	rm -rf $(PACKAGE)
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME) -C $(PACKAGE)
	BIN="$$(find $(PACKAGE) -type f -name $(PACKAGE) | head -n 1)"; \
	test -n "$$BIN"; \
	if [ "$$BIN" != "$(PACKAGE)/$(PACKAGE)" ]; then mv -f "$$BIN" $(PACKAGE)/$(PACKAGE); fi; \
	find $(PACKAGE) -mindepth 1 ! -path "$(PACKAGE)/$(PACKAGE)" -exec rm -rf {} +; \
	chmod +x $(PACKAGE)/$(PACKAGE)

clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	nfpm package --config nfpm.yaml --packager rpm --target ../../dist/rpm.aarch64/
deb:
	nfpm package --config nfpm.yaml --packager deb --target ../../dist/deb.arm64/


.PHONY: all get link meta download extract clean build rpm deb
