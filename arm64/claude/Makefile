#==============================================================#
# File      :   Makefile
# Ctime     :   2025-12-24
# Mtime     :   2026-01-08
# Desc      :   Makefile shortcuts for claude rpm/deb building
# Path      :   Makefile
# Copyright (C) 2018-2025 Ruohang Feng (rh@vonng.com)
#==============================================================#
PACKAGE=claude
VERSION=2.1.107
PLATFORM=linux-arm64
INSTALLER_URL=https://claude.ai/install.sh
BUCKET=$(shell curl -fsSL $(INSTALLER_URL) | sed -n 's/^GCS_BUCKET="\([^"]*\)"/\1/p')
TARBALL=claude-$(VERSION)-linux-arm64.gz
WEB_URL=$(BUCKET)/$(VERSION)/$(PLATFORM)/claude

default: all
all: download build clean
get: download

# print download link and download command
link:
	@echo $(PACKAGE) $(VERSION)
	@echo curl -fL $(WEB_URL) -o $(PACKAGE) '&&' gzip -c $(PACKAGE) '>' $(TARBALL)

# download tarball and extract binary
download:
	if [ -f ../tarball/$(TARBALL) ]; then cp ../tarball/$(TARBALL) .; else curl -fL $(WEB_URL) -o $(PACKAGE) && gzip -c $(PACKAGE) > $(TARBALL) && rm -f $(PACKAGE); fi
	gunzip -c $(TARBALL) > $(PACKAGE) && chmod +x $(PACKAGE)

# remove binary, tarball, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(TARBALL) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	nfpm package --config claude.yaml --packager rpm --target ../../dist/rpm.aarch64/
deb:
	nfpm package --config claude.yaml --packager deb --target ../../dist/deb.arm64/


.PHONY: all get link download clean build rpm deb
