#==============================================================#
# File      :   Makefile
# Ctime     :   2025-12-04
# Mtime     :   2025-12-04
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

PACKAGE=garage
VERSION=2.3.0
RELEASE_PAGE=https://git.deuxfleurs.fr/Deuxfleurs/garage/releases/tag/v$(VERSION)
FILENAME=$(PACKAGE)
CACHE=$(PACKAGE)-v$(VERSION)-linux-$(ARCH)
PLATFORM=$(RARCH)-unknown-linux-musl
WEB_URL=https://garagehq.deuxfleurs.fr/_releases/v$(VERSION)/$(PLATFORM)/garage
SHA256_amd64=f98d317942bb341151a2775162016bb50cf86b865d0108de03eb5db16e2120cd
SHA256_arm64=8ced2ad3040262571de08aa600959aa51f97576d55da7946fcde6f66140705e2
SHA256=$(SHA256_$(ARCH))

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract build clean
get: download verify extract

# print download link and download command
link:
	@echo $(PACKAGE) $(VERSION) on $(RELEASE_PAGE)
	@echo curl -fSL $(WEB_URL) -o $(FILENAME)

# download configured release binary to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(CACHE) ]; then cp ../tarball/$(CACHE) $(FILENAME); else curl -fSL $(WEB_URL) -o $(FILENAME); fi

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
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link download verify extract clean build rpm deb one
