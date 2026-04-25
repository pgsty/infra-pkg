#==============================================================#
# File      :   Makefile
# Ctime     :   2025-12-24
# Mtime     :   2026-01-08
# Desc      :   Makefile shortcuts for claude rpm/deb building
# Path      :   Makefile
# Copyright (C) 2018-2025 Ruohang Feng (rh@vonng.com)
#==============================================================#
PACKAGE=claude
VERSION=2.1.119
PLATFORM=linux-x64
INSTALLER_URL=https://claude.ai/install.sh
BUCKET=https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases
TARBALL=claude-$(VERSION)-linux-amd64.gz
WEB_URL=$(BUCKET)/$(VERSION)/$(PLATFORM)/claude
PROXY=http://127.0.0.1:8118
CURL=curl --proxy $(PROXY) --retry 5 --retry-delay 2 --retry-connrefused -fL

default: all
all: download build clean
get: download

# print download link and download command
link:
	@echo $(PACKAGE) $(VERSION)
	@echo $(CURL) $(WEB_URL) -o $(PACKAGE) '&&' gzip -c $(PACKAGE) '>' $(TARBALL)

# download tarball and extract binary
download:
	if [ -f ../tarball/$(TARBALL) ]; then cp ../tarball/$(TARBALL) .; else $(CURL) $(WEB_URL) -o $(PACKAGE) && gzip -c $(PACKAGE) > $(TARBALL) && rm -f $(PACKAGE); fi
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
