#==============================================================#
# File      :   Makefile
# Ctime     :   2025-12-24
# Mtime     :   2026-01-08
# Desc      :   Makefile shortcuts for claude rpm/deb building
# Path      :   Makefile
# Copyright (C) 2018-2025 Ruohang Feng (rh@vonng.com)
#==============================================================#
PACKAGE=claude
VERSION=2.1.15
TARBALL=claude-linux-amd64.gz
WEB_URL=https://storage.googleapis.com/anthropic-public/claude-code/$(TARBALL)

default: all
all: download build clean
get: download

# print download link and download command
link:
	@echo $(PACKAGE) $(VERSION)
	@echo curl -fL $(WEB_URL) -o $(TARBALL)

# download tarball and extract binary
download:
	if [ -f ../tarball/$(TARBALL) ]; then cp ../tarball/$(TARBALL) .; else curl -fL $(WEB_URL) -o $(TARBALL); fi
	gunzip -c $(TARBALL) > $(PACKAGE) && chmod +x $(PACKAGE)

# remove binary, tarball, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(TARBALL) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	nfpm package --config claude.yaml --packager rpm --target ../../dist/rpm.x86_64/
deb:
	nfpm package --config claude.yaml --packager deb --target ../../dist/deb.amd64/


.PHONY: all get link download clean build rpm deb
