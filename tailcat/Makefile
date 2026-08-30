#==============================================================#
# File      :   Makefile
# Ctime     :   2026-08-30
# Mtime     :   2026-08-30
# Desc      :   Tailcat reproducible source RPM/DEB package
# Path      :   tailcat/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=tailscale/tailcat
PACKAGE=tailcat
VERSION=0.0.0-20260830010511-7c2a6ea60429
BUILD_VERSION=v$(VERSION)
COMMIT=7c2a6ea6042907e1b2cec40fc85efdebdbdefcf5
SOURCE_DATE_EPOCH=1788051911
GO_BUILD_VERSION=1.26.5
export SOURCE_DATE_EPOCH

SOURCE_ARCHIVE=$(PACKAGE)-$(COMMIT).tar.gz
VENDOR_ARCHIVE=$(PACKAGE)-$(VERSION)-vendor.tar.zst
SOURCE_URL=https://codeload.github.com/$(REPONAME)/tar.gz/$(COMMIT)
SHA256_SOURCE=9930e5c6bba8f950a89e8624a870b6190883310022cbbf564364b2960f506135
SHA256_VENDOR=e458f9ef2a1c29a58b7e6858c747ced55efe531f0c1f313ed6408d07be84dcde
SOURCE=source
STAGE=stage
BINARY=$(STAGE)/usr/bin/$(PACKAGE)
GO ?= go
GTAR ?= $(shell command -v gtar 2>/dev/null || command -v tar)
PROXY ?= http://127.0.0.1:8118
PROXY_ARG=$(if $(strip $(PROXY)),--proxy $(PROXY),)
CURL=curl --http1.1 --retry 5 --retry-delay 2 --retry-connrefused --continue-at - $(PROXY_ARG) -fL


default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract binary legal build clean
get: download verify

link:
	@echo $(REPONAME) $(BUILD_VERSION) at $(COMMIT)
	@echo $(CURL) $(SOURCE_URL) -o $(SOURCE_ARCHIVE)
	@echo vendor bundle: ../tarball/$(VENDOR_ARCHIVE)

download-source:
	if [ -f ../tarball/$(SOURCE_ARCHIVE) ]; then cp ../tarball/$(SOURCE_ARCHIVE) .; else $(CURL) $(SOURCE_URL) -o $(SOURCE_ARCHIVE); fi

verify-source:
	@if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256_SOURCE)  $(SOURCE_ARCHIVE)" | sha256sum -c -; else echo "$(SHA256_SOURCE)  $(SOURCE_ARCHIVE)" | shasum -a 256 -c -; fi
	tar -tzf $(SOURCE_ARCHIVE) >/dev/null

vendor-bundle: download-source verify-source
	@test "$$($(GO) version | awk '{print $$3}')" = "go$(GO_BUILD_VERSION)" || (echo "go $(GO_BUILD_VERSION) is required to regenerate $(VENDOR_ARCHIVE)" >&2; exit 1)
	rm -rf $(SOURCE) $(VENDOR_ARCHIVE)
	mkdir -p $(SOURCE)
	tar -xf $(SOURCE_ARCHIVE) -C $(SOURCE) --strip-components 1
	cd $(SOURCE) && HTTPS_PROXY=$(PROXY) HTTP_PROXY=$(PROXY) GOTOOLCHAIN=local $(GO) mod verify
	cd $(SOURCE) && HTTPS_PROXY=$(PROXY) HTTP_PROXY=$(PROXY) GOTOOLCHAIN=local $(GO) mod vendor
	cd $(SOURCE) && $(GTAR) --sort=name --mtime=@$(SOURCE_DATE_EPOCH) --owner=0 --group=0 --numeric-owner -cf - vendor | zstd -19 -T0 -o "$(CURDIR)/$(VENDOR_ARCHIVE)"
	@if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256_VENDOR)  $(VENDOR_ARCHIVE)" | sha256sum -c -; else echo "$(SHA256_VENDOR)  $(VENDOR_ARCHIVE)" | shasum -a 256 -c -; fi
	cp $(VENDOR_ARCHIVE) ../tarball/$(VENDOR_ARCHIVE)
	rm -rf $(SOURCE)

download-vendor:
	@if [ -f ../tarball/$(VENDOR_ARCHIVE) ]; then \
		cp ../tarball/$(VENDOR_ARCHIVE) .; \
	else \
		$(MAKE) vendor-bundle; \
	fi

download: download-source download-vendor

verify: verify-source
	@if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256_VENDOR)  $(VENDOR_ARCHIVE)" | sha256sum -c -; else echo "$(SHA256_VENDOR)  $(VENDOR_ARCHIVE)" | shasum -a 256 -c -; fi

extract:
	rm -rf $(SOURCE) $(STAGE)
	mkdir -p $(SOURCE) $(STAGE)/usr/bin $(STAGE)/usr/share/doc/$(PACKAGE)
	tar -xf $(SOURCE_ARCHIVE) -C $(SOURCE) --strip-components 1
	zstd -dc $(VENDOR_ARCHIVE) | tar -xf - -C $(SOURCE)

binary:
	@test "$$($(GO) version | awk '{print $$3}')" = "go$(GO_BUILD_VERSION)" || (echo "go $(GO_BUILD_VERSION) is required to build $(PACKAGE)" >&2; exit 1)
	cd $(SOURCE) && GOTOOLCHAIN=local GOOS=linux GOARCH=$(ARCH) CGO_ENABLED=0 GOFLAGS=-mod=vendor \
		$(GO) build -trimpath -buildvcs=false \
		-ldflags '-s -w -buildid= -X main.version=$(BUILD_VERSION)' \
		-o "$(CURDIR)/$(BINARY)" ./cmd/tailcat
	@case "$(ARCH)" in amd64) expected="x86-64" ;; arm64) expected="ARM aarch64" ;; *) echo "unsupported ARCH=$(ARCH)" >&2; exit 1 ;; esac; \
		file $(BINARY) | grep -F "$$expected" >/dev/null
	@file $(BINARY) | grep -F "statically linked" >/dev/null
	@strings $(BINARY) | grep -F -x "$(BUILD_VERSION)" >/dev/null

legal:
	cp $(SOURCE)/LICENSE $(STAGE)/usr/share/doc/$(PACKAGE)/LICENSE

clean:
	rm -rf $(SOURCE) $(STAGE) $(SOURCE_ARCHIVE) $(VENDOR_ARCHIVE) $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link download-source verify-source vendor-bundle download-vendor download verify extract binary legal clean build rpm deb one
