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
VERSION=2.1.278
PLATFORM_amd64=linux-x64
PLATFORM_arm64=linux-arm64
PLATFORM=$(PLATFORM_$(ARCH))
INSTALLER_URL=https://claude.ai/install.sh
BUCKET=https://downloads.claude.ai/claude-code-releases
TARBALL=claude-$(VERSION)-linux-$(ARCH).gz
WEB_URL=$(BUCKET)/$(VERSION)/$(PLATFORM)/claude
SHA256_amd64=5c4735937844e84f8a93306e841a5b0e12252909b07870f789b190468da147ab
SHA256_arm64=7de6cab134e48321148e30182c98614118e8f4666819412bead45865190b34ed
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
