#==============================================================#
# File      :   Makefile
# Ctime     :   2025-12-24
# Mtime     :   2025-12-24
# Desc      :   Makefile shortcuts for claude rpm/deb building
# Path      :   Makefile
# Copyright (C) 2018-2025 Ruohang Feng (rh@vonng.com)
#==============================================================#
PACKAGE=claude
VERSION=2.0.76
WEB_URL=https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases/$(VERSION)/linux-x64/claude

default: all
all: download build clean
get: download

# print download link and download command
link:
	@echo $(PACKAGE) $(VERSION)
	@echo curl -fL $(WEB_URL) -o $(PACKAGE)

# download binary to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(PACKAGE) ]; then cp ../tarball/$(PACKAGE) .; else curl -fL $(WEB_URL) -o $(PACKAGE); fi
	chmod +x $(PACKAGE)

# remove binary, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	nfpm package --config ccm.yaml --packager rpm --target ../../dist/rpm.x86_64/
deb:
	nfpm package --config ccm.yaml --packager deb --target ../../dist/deb.amd64/


.PHONY: all get link download clean build rpm deb
