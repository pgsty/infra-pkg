#==============================================================#
# File      :   Makefile
# Ctime     :   2026-07-19
# Mtime     :   2026-07-20
# Desc      :   Makefile shortcuts for K3s RPM/DEB building
# Path      :   arm64/k3s/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME=k3s-io/k3s
PACKAGE=k3s
IMAGE_PACKAGE=k3s-images
VERSION=1.36.2
UPSTREAM_REV=1
RELEASE=1
UPSTREAM_VERSION=v$(VERSION)+k3s$(UPSTREAM_REV)
URL_VERSION=v$(VERSION)%2Bk3s$(UPSTREAM_REV)
ARCH=arm64
BINARY_ASSET=k3s
UPSTREAM_BINARY_ASSET=k3s-arm64
IMAGE_ASSET=k3s-airgap-images-$(ARCH).tar.zst
CHECKSUM_ASSET=sha256sum-$(ARCH).txt
IMAGE_LIST_ASSET=k3s-images.txt
CACHE_BINARY=k3s-$(UPSTREAM_VERSION)-linux-$(ARCH)
CACHE_IMAGE=k3s-airgap-images-$(UPSTREAM_VERSION)-$(ARCH).tar.zst
CACHE_CHECKSUM=k3s-sha256sum-$(UPSTREAM_VERSION)-$(ARCH).txt
CACHE_IMAGE_LIST=k3s-images-$(UPSTREAM_VERSION).txt
BINARY_SHA256=1dc5fc17f15c28fa0a3f011cee28ad613f918c3d967a426e5a05d43ddb239817
IMAGE_SHA256=26a5528bb00c7beac8c88399af77c71123e74fedbba5b03c1c5ae003c838880f
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/$(URL_VERSION)
RELEASE_BASE=https://github.com/$(REPONAME)/releases/download/$(URL_VERSION)
CURL=curl --http1.1 --retry 5 --retry-delay 2 --retry-all-errors --continue-at - -fL

default: binary
all: bundle
binary: download-common download-binary verify-binary build-binary clean
airgap: download-common download-airgap verify-airgap build-airgap clean
bundle: download-common download-binary download-airgap verify build clean
get: download-common download-binary download-airgap verify

link:
	@echo $(PACKAGE) $(VERSION)-$(RELEASE) from upstream $(UPSTREAM_VERSION) on $(RELEASE_PAGE)
	@echo $(CURL) $(RELEASE_BASE)/$(UPSTREAM_BINARY_ASSET) -o $(BINARY_ASSET)
	@echo $(CURL) $(RELEASE_BASE)/$(IMAGE_ASSET) -o $(IMAGE_ASSET)
	@echo $(CURL) $(RELEASE_BASE)/$(CHECKSUM_ASSET) -o $(CHECKSUM_ASSET)
	@echo $(CURL) $(RELEASE_BASE)/$(IMAGE_LIST_ASSET) -o $(IMAGE_LIST_ASSET)

download-common:
	if [ -f ../tarball/$(CACHE_CHECKSUM) ]; then cp ../tarball/$(CACHE_CHECKSUM) $(CHECKSUM_ASSET); else $(CURL) $(RELEASE_BASE)/$(CHECKSUM_ASSET) -o $(CHECKSUM_ASSET); fi
	if [ -f ../tarball/$(CACHE_IMAGE_LIST) ]; then cp ../tarball/$(CACHE_IMAGE_LIST) $(IMAGE_LIST_ASSET); else $(CURL) $(RELEASE_BASE)/$(IMAGE_LIST_ASSET) -o $(IMAGE_LIST_ASSET); fi

download-binary:
	if [ -f ../tarball/$(CACHE_BINARY) ]; then cp ../tarball/$(CACHE_BINARY) $(BINARY_ASSET); else $(CURL) $(RELEASE_BASE)/$(UPSTREAM_BINARY_ASSET) -o $(BINARY_ASSET); fi
	chmod 0755 $(BINARY_ASSET)

download-airgap:
	if [ -f ../tarball/$(CACHE_IMAGE) ]; then cp ../tarball/$(CACHE_IMAGE) $(IMAGE_ASSET); else $(CURL) $(RELEASE_BASE)/$(IMAGE_ASSET) -o $(IMAGE_ASSET); fi

verify: verify-binary verify-airgap

verify-binary:
	test "$$(awk '$$2 == "$(UPSTREAM_BINARY_ASSET)" { print $$1 }' $(CHECKSUM_ASSET))" = "$(BINARY_SHA256)"
	if command -v sha256sum >/dev/null 2>&1; then echo "$(BINARY_SHA256)  $(BINARY_ASSET)" | sha256sum -c -; else echo "$(BINARY_SHA256)  $(BINARY_ASSET)" | shasum -a 256 -c -; fi
	file $(BINARY_ASSET) | grep -q 'ARM aarch64'
	if [ "$$(uname -s)-$$(uname -m)" = "Linux-aarch64" ]; then ./$(BINARY_ASSET) --version | grep -Fq 'k3s version $(UPSTREAM_VERSION) '; fi

verify-airgap:
	test "$$(awk '$$2 == "$(IMAGE_ASSET)" { print $$1 }' $(CHECKSUM_ASSET))" = "$(IMAGE_SHA256)"
	if command -v sha256sum >/dev/null 2>&1; then echo "$(IMAGE_SHA256)  $(IMAGE_ASSET)" | sha256sum -c -; else echo "$(IMAGE_SHA256)  $(IMAGE_ASSET)" | shasum -a 256 -c -; fi
	if command -v zstd >/dev/null 2>&1; then zstd -t $(IMAGE_ASSET); fi
	test "$$(wc -l < $(IMAGE_LIST_ASSET))" -gt 0

clean:
	rm -f $(BINARY_ASSET) $(IMAGE_ASSET) $(CHECKSUM_ASSET) $(IMAGE_LIST_ASSET)
	rm -f $(PACKAGE)*.rpm $(PACKAGE)*.deb $(IMAGE_PACKAGE)*.rpm $(IMAGE_PACKAGE)*.deb

build: build-binary build-airgap
build-binary: rpm deb
build-airgap: airgap-rpm airgap-deb

rpm:
	mkdir -p ../../dist/rpm.aarch64/
	nfpm package --config nfpm-k3s.yaml --packager rpm --target ../../dist/rpm.aarch64/

deb:
	mkdir -p ../../dist/deb.arm64/
	nfpm package --config nfpm-k3s.yaml --packager deb --target ../../dist/deb.arm64/

airgap-rpm:
	mkdir -p ../../dist/rpm.aarch64/
	nfpm package --config nfpm-airgap.yaml --packager rpm --target ../../dist/rpm.aarch64/

airgap-deb:
	mkdir -p ../../dist/deb.arm64/
	nfpm package --config nfpm-airgap.yaml --packager deb --target ../../dist/deb.arm64/

.PHONY: default all binary airgap bundle get link download-common download-binary download-airgap \
	verify verify-binary verify-airgap clean build build-binary build-airgap rpm deb airgap-rpm airgap-deb
