#==============================================================#
# File      :   Makefile
# Ctime     :   2025-12-04
# Mtime     :   2025-12-04
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#
PACKAGE=garage
VERSION=2.1.0
RELEASE_PAGE=https://garagehq.deuxfleurs.fr/download/
FILENAME=$(PACKAGE)-aarch64-unknown-linux-musl
WEB_URL=https://garagehq.deuxfleurs.fr/_releases/v$(VERSION)/$(FILENAME)

default: all
all: download extract build clean
get: download extract

# print download link and download command
link:
	@echo $(PACKAGE) $(VERSION) on $(RELEASE_PAGE)
	@echo curl -SL $(WEB_URL) -o $(FILENAME)

# download latest release binary to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(PACKAGE) ]; then cp ../tarball/$(PACKAGE) .; else curl -SL $(WEB_URL) -o $(PACKAGE); fi

# extract (no-op for single binary, just ensure it's in place)
extract:
	chmod +x $(PACKAGE)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	nfpm package --config nfpm.yaml --packager rpm --target ../../dist/rpm.aarch64/
deb:
	nfpm package --config nfpm.yaml --packager deb --target ../../dist/deb.arm64/


.PHONY: all get link download extract clean build rpm deb
