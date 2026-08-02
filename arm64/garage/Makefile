#==============================================================#
# File      :   Makefile
# Ctime     :   2025-12-04
# Mtime     :   2025-12-04
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#
PACKAGE=garage
VERSION=2.3.0
RELEASE_PAGE=https://git.deuxfleurs.fr/Deuxfleurs/garage/releases/tag/v$(VERSION)
FILENAME=$(PACKAGE)
PLATFORM=aarch64-unknown-linux-musl
WEB_URL=https://garagehq.deuxfleurs.fr/_releases/v$(VERSION)/$(PLATFORM)/garage
SHA256=8ced2ad3040262571de08aa600959aa51f97576d55da7946fcde6f66140705e2

default: all
all: download verify extract build clean
get: download verify extract

# print download link and download command
link:
	@echo $(PACKAGE) $(VERSION) on $(RELEASE_PAGE)
	@echo curl -fSL $(WEB_URL) -o $(FILENAME)

# download configured release binary to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else curl -fSL $(WEB_URL) -o $(FILENAME); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi

# extract (no-op for single binary, just ensure it's in place)
extract:
	chmod +x $(FILENAME)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../../bin/nfpm package --config nfpm.yaml --packager rpm --target ../../dist/rpm.aarch64/
deb:
	../../bin/nfpm package --config nfpm.yaml --packager deb --target ../../dist/deb.arm64/


.NOTPARALLEL:

.PHONY: all get link download verify extract clean build rpm deb
