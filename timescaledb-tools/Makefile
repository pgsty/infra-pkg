#==============================================================#
# File      :   Makefile
# Ctime     :   2024-07-25
# Mtime     :   2025-11-23
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME1=timescale/timescaledb-tune
REPONAME2=timescale/timescaledb-parallel-copy
PACKAGE=timescaledb-tools
VERSION=0.19.1
VERSION2=0.13.2
RELEASE=1PGSTY
RELEASE_PAGE1=https://github.com/$(REPONAME1)/releases/tag/v$(VERSION)
RELEASE_PAGE2=https://github.com/$(REPONAME2)/releases/tag/v$(VERSION2)
FILENAME1=timescaledb-tune
FILENAME2=timescaledb-parallel-copy
CACHE1=$(FILENAME1)-v$(VERSION)-linux-$(ARCH)
CACHE2=$(FILENAME2)-v$(VERSION2)-linux-$(ARCH)
SHA2561_amd64=0bcc530177a4649e8e5726ecb91fb84b4ce6032b4258e7069e459b5a75889877
SHA2561_arm64=da0fcec297f6d0aa1744c75969122b16b3cb5e6a60ebdf3bac3ed13acd0f934e
SHA2561=$(SHA2561_$(ARCH))
SHA2562_amd64=a31c22b63eef0a1c8b14ffc92081cc9d5f50d69a7da628c1663294bc2f34d39a
SHA2562_arm64=2587a8b0d5a6e628918f93bada07890bfc102f4b920261d2e589da65a0bc7546
SHA2562=$(SHA2562_$(ARCH))
CURL=curl --http1.1 --retry 5 --retry-delay 2 --retry-connrefused --fail --silent --show-error --location

# These four Linux binaries are intentional one-shot build artifacts. This
# recipe consumes only their versioned cache names and pinned checksums; it does
# not rebuild them during routine package assembly.


default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean
get: download verify

# print upstream release pages
link:
	@echo $(REPONAME1) $(VERSION) on $(RELEASE_PAGE1)
	@echo $(REPONAME2) $(VERSION2) on $(RELEASE_PAGE2)

# get pinned release info
meta:
	$(CURL) "https://api.github.com/repos/$(REPONAME1)/releases/tags/v$(VERSION)" | tee meta.json
	$(CURL) "https://api.github.com/repos/$(REPONAME2)/releases/tags/v$(VERSION2)" | tee meta2.json

# copy locally built Linux binaries from the architecture cache
download:
	cp ../tarball/$(CACHE1) $(FILENAME1)
	cp ../tarball/$(CACHE2) $(FILENAME2)

# verify the exact cached inputs
verify:
	@if command -v sha256sum >/dev/null 2>&1; then \
		printf '%s  %s\n%s  %s\n' "$(SHA2561)" "$(FILENAME1)" "$(SHA2562)" "$(FILENAME2)" | sha256sum -c -; \
	else \
		printf '%s  %s\n%s  %s\n' "$(SHA2561)" "$(FILENAME1)" "$(SHA2562)" "$(FILENAME2)" | shasum -a 256 -c -; \
	fi

# remove copied binaries and local package outputs
clean:
	rm -f $(FILENAME1) $(FILENAME2) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link meta download verify clean build rpm deb one
