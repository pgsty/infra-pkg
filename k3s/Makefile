#==============================================================#
# File      :   Makefile
# Desc      :   Build the K3s RPM/DEB package
# Path      :   k3s/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=k3s-io/k3s
PACKAGE=k3s
VERSION=1.36.3
UPSTREAM_REV=1
RELEASE=1PGSTY
UPSTREAM_VERSION=v$(VERSION)+k3s$(UPSTREAM_REV)
URL_VERSION=v$(VERSION)%2Bk3s$(UPSTREAM_REV)
UPSTREAM_ASSET_amd64=k3s
UPSTREAM_ASSET_arm64=k3s-arm64
UPSTREAM_ASSET=$(UPSTREAM_ASSET_$(ARCH))
FILE_MAGIC_amd64=x86-64
FILE_MAGIC_arm64=ARM aarch64
FILE_MAGIC=$(FILE_MAGIC_$(ARCH))
CHECKSUM_ASSET=sha256sum.txt
UPSTREAM_CHECKSUM_ASSET=sha256sum-$(ARCH).txt
CACHE_BINARY=k3s-$(UPSTREAM_VERSION)-linux-$(ARCH)
CACHE_CHECKSUM=k3s-sha256sum-$(UPSTREAM_VERSION)-$(ARCH).txt
SHA256_amd64=2f98a9f8fe5782479ee2d54e70a1b10a7f6fd4cae8d38ed3098452dc6eed76b5
SHA256_arm64=c9a209103f480f163b7c6a56f00862b4481927b284dc29a3716bb70d886691a8
SHA256=$(SHA256_$(ARCH))
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/$(URL_VERSION)
RELEASE_BASE=https://github.com/$(REPONAME)/releases/download/$(URL_VERSION)
CURL=curl --http1.1 --retry 5 --retry-delay 2 --retry-all-errors --continue-at - -fL

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify build clean
get: download verify

link:
	@echo $(PACKAGE) $(VERSION)-$(RELEASE) from upstream $(UPSTREAM_VERSION) on $(RELEASE_PAGE)
	@echo $(CURL) $(RELEASE_BASE)/$(UPSTREAM_ASSET) -o $(PACKAGE)

download:
	if [ -f ../tarball/$(CACHE_CHECKSUM) ]; then cp ../tarball/$(CACHE_CHECKSUM) $(CHECKSUM_ASSET); else $(CURL) $(RELEASE_BASE)/$(UPSTREAM_CHECKSUM_ASSET) -o $(CHECKSUM_ASSET); fi
	if [ -f ../tarball/$(CACHE_BINARY) ]; then cp ../tarball/$(CACHE_BINARY) $(PACKAGE); else $(CURL) $(RELEASE_BASE)/$(UPSTREAM_ASSET) -o $(PACKAGE); fi
	chmod 0755 $(PACKAGE)

verify:
	test "$$(awk '$$2 == "$(UPSTREAM_ASSET)" { print $$1 }' $(CHECKSUM_ASSET))" = "$(SHA256)"
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(PACKAGE)" | sha256sum -c -; else echo "$(SHA256)  $(PACKAGE)" | shasum -a 256 -c -; fi
	file $(PACKAGE) | grep -q '$(FILE_MAGIC)'
	if [ "$$(uname -s)-$$(uname -m)" = "Linux-$(RARCH)" ]; then ./$(PACKAGE) --version | grep -Fq 'k3s version $(UPSTREAM_VERSION) '; fi

clean:
	rm -f $(PACKAGE) $(CHECKSUM_ASSET) $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	mkdir -p ../dist/rpm/
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	mkdir -p ../dist/deb/
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/

.NOTPARALLEL:

.PHONY: default all one get link download verify clean build rpm deb
