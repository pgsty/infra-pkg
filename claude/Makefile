#==============================================================#
# File      :   Makefile
# Ctime     :   2025-12-24
# Mtime     :   2026-01-08
# Desc      :   Makefile shortcuts for claude rpm/deb building
# Path      :   Makefile
# Copyright (C) 2018-2025 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

PACKAGE=claude
VERSION=2.1.227
PLATFORM_amd64=linux-x64
PLATFORM_arm64=linux-arm64
PLATFORM=$(PLATFORM_$(ARCH))
INSTALLER_URL=https://claude.ai/install.sh
BUCKET=https://downloads.claude.ai/claude-code-releases
TARBALL=claude-$(VERSION)-linux-$(ARCH).gz
WEB_URL=$(BUCKET)/$(VERSION)/$(PLATFORM)/claude
SHA256_amd64=6832dc3f1797b890b71116e5f2dbbf9a83fd3d0498c235b4b0f9cd0e6e499ad6
SHA256_arm64=db47335532cbcab67a4b3ab16d8f3f77976bf85d53c7d79f8296538aa22bfce6
SHA256=$(SHA256_$(ARCH))
PROXY=http://127.0.0.1:8118
CURL=curl --proxy $(PROXY) --retry 5 --retry-delay 2 --retry-connrefused -fL

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean
get: download verify

# print download link and download command
link:
	@echo $(PACKAGE) $(VERSION)
	@echo $(CURL) $(WEB_URL) -o $(PACKAGE) '&&' gzip -n -c $(PACKAGE) '>' $(TARBALL)

# download tarball and extract binary
download:
	if [ -f ../tarball/$(TARBALL) ]; then cp ../tarball/$(TARBALL) .; else $(CURL) $(WEB_URL) -o $(PACKAGE) && gzip -n -c $(PACKAGE) > $(TARBALL) && rm -f $(PACKAGE); fi
	gunzip -c $(TARBALL) > $(PACKAGE) && chmod +x $(PACKAGE)

# verify the official release binary before packaging
verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(PACKAGE)" | sha256sum -c -; else echo "$(SHA256)  $(PACKAGE)" | shasum -a 256 -c -; fi

# remove binary, tarball, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(TARBALL) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../bin/nfpm package --config claude.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config claude.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link download verify clean build rpm deb one
