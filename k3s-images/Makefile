#==============================================================#
# File      :   Makefile
# Desc      :   Build the K3s air-gap image RPM/DEB package
# Path      :   k3s-images/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=k3s-io/k3s
PACKAGE=k3s-images
VERSION=1.36.4
UPSTREAM_REV=1
RELEASE=1PGSTY
UPSTREAM_VERSION=v$(VERSION)+k3s$(UPSTREAM_REV)
URL_VERSION=v$(VERSION)%2Bk3s$(UPSTREAM_REV)
IMAGE_ASSET=k3s-airgap-images.tar.zst
UPSTREAM_IMAGE_ASSET=k3s-airgap-images-$(ARCH).tar.zst
CHECKSUM_ASSET=sha256sum.txt
UPSTREAM_CHECKSUM_ASSET=sha256sum-$(ARCH).txt
IMAGE_LIST_ASSET=k3s-images.txt
CACHE_IMAGE=k3s-airgap-images-$(UPSTREAM_VERSION)-$(ARCH).tar.zst
CACHE_CHECKSUM=k3s-sha256sum-$(UPSTREAM_VERSION)-$(ARCH).txt
CACHE_IMAGE_LIST=k3s-images-$(UPSTREAM_VERSION).txt
SHA256_amd64=9024613e2d468c51ba0e5ba21898604c41339354449fb3338cc6a7931189eb6a
SHA256_arm64=9d3c4c2197bcf857ca17633aa393bad683cc982ddd408620f93036a3cca953b5
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
	@echo $(CURL) $(RELEASE_BASE)/$(UPSTREAM_IMAGE_ASSET) -o $(IMAGE_ASSET)

download:
	if [ -f ../tarball/$(CACHE_CHECKSUM) ]; then cp ../tarball/$(CACHE_CHECKSUM) $(CHECKSUM_ASSET); else $(CURL) $(RELEASE_BASE)/$(UPSTREAM_CHECKSUM_ASSET) -o $(CHECKSUM_ASSET); fi
	if [ -f ../tarball/$(CACHE_IMAGE_LIST) ]; then cp ../tarball/$(CACHE_IMAGE_LIST) $(IMAGE_LIST_ASSET); else $(CURL) $(RELEASE_BASE)/$(IMAGE_LIST_ASSET) -o $(IMAGE_LIST_ASSET); fi
	if [ -f ../tarball/$(CACHE_IMAGE) ]; then cp ../tarball/$(CACHE_IMAGE) $(IMAGE_ASSET); else $(CURL) $(RELEASE_BASE)/$(UPSTREAM_IMAGE_ASSET) -o $(IMAGE_ASSET); fi
	cp -f src/AIRGAP.$(ARCH).md AIRGAP.md

verify:
	test "$$(awk '$$2 == "$(UPSTREAM_IMAGE_ASSET)" { print $$1 }' $(CHECKSUM_ASSET))" = "$(SHA256)"
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(IMAGE_ASSET)" | sha256sum -c -; else echo "$(SHA256)  $(IMAGE_ASSET)" | shasum -a 256 -c -; fi
	if command -v zstd >/dev/null 2>&1; then zstd -t $(IMAGE_ASSET); fi
	test "$$(wc -l < $(IMAGE_LIST_ASSET))" -gt 0

clean:
	rm -f $(IMAGE_ASSET) $(CHECKSUM_ASSET) $(IMAGE_LIST_ASSET) AIRGAP.md $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	mkdir -p ../dist/rpm/
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	mkdir -p ../dist/deb/
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/

.NOTPARALLEL:

.PHONY: default all one get link download verify clean build rpm deb
