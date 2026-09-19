#==============================================================#
# File      :   Makefile
# Ctime     :   2026-08-19
# Mtime     :   2026-08-19
# Desc      :   cargo-pgrx 0.19.2 versioned RPM/DEB package
# Path      :   cargo-pgrx-0192/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= $(if $(filter aarch64 arm64,$(shell uname -m)),arm64,amd64)
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

PACKAGE=cargo-pgrx-0192
VERSION=0.19.2
RELEASE=1PGSTY
RUST_BUILD_VERSION ?= 1.98.1
RUST_MIN_VERSION=1.96.0
RUST_ROOT=/usr/lib/pgsty/rust
GLIBC_FLOOR ?= 2.28
GCC_FLOOR ?= 4.2.0
SOURCE_DATE_EPOCH=1785424042
export GLIBC_FLOOR GCC_FLOOR RUST_MIN_VERSION SOURCE_DATE_EPOCH

CRATE=cargo-pgrx-$(VERSION).crate
VENDOR=cargo-pgrx-$(VERSION)-vendor.tar.zst
SHA256_CRATE=e9f7db844ff3ab045da9f52609dd096c16296a9ee6ec41180da5c99e057848a8
SHA256_VENDOR=0ef9fb035145a4750fb9914da81aaafa0c54b3b72f6ac882f6016326db4b6844
CRATE_URL=https://static.crates.io/crates/cargo-pgrx/$(CRATE)
VENDOR_URL ?=
SOURCE=source
TARGET=target
STAGE=stage
PREFIX=/usr/lib/pgsty/cargo-pgrx/$(VERSION)
CURL=curl --http1.1 --retry 5 --retry-delay 2 --retry-connrefused --continue-at - -fL


default: one
all: one
one: download verify extract binary legal build clean
get: download verify

link:
	@echo cargo-pgrx $(VERSION)
	@echo $(CURL) $(CRATE_URL) -o $(CRATE)
	@if [ -n "$(VENDOR_URL)" ]; then echo $(CURL) $(VENDOR_URL) -o $(VENDOR); else echo "vendor bundle: ../tarball/$(VENDOR)"; fi

download-crate:
	if [ -f ../tarball/$(CRATE) ]; then cp ../tarball/$(CRATE) .; else $(CURL) $(CRATE_URL) -o $(CRATE); fi

verify-crate:
	@if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256_CRATE)  $(CRATE)" | sha256sum -c -; else echo "$(SHA256_CRATE)  $(CRATE)" | shasum -a 256 -c -; fi

vendor-bundle: download-crate verify-crate
	@test -x "$(RUST_ROOT)/bin/cargo" || (echo "install rust-toolchain before regenerating $(VENDOR)" >&2; exit 1)
	rm -rf $(SOURCE) cargo-home $(VENDOR)
	mkdir -p $(SOURCE)/.cargo cargo-home
	tar -xf $(CRATE) -C $(SOURCE) --strip-components 1
	cd $(SOURCE) && CARGO_HOME="$(CURDIR)/cargo-home" "$(RUST_ROOT)/bin/cargo" vendor --locked --respect-source-config vendor > .cargo/vendor-config.toml
	cd $(SOURCE) && tar --sort=name --mtime=@$(SOURCE_DATE_EPOCH) --owner=0 --group=0 --numeric-owner -cf - vendor | zstd -19 -T0 -o "$(CURDIR)/$(VENDOR)"
	@if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256_VENDOR)  $(VENDOR)" | sha256sum -c -; else echo "$(SHA256_VENDOR)  $(VENDOR)" | shasum -a 256 -c -; fi
	cp $(VENDOR) ../tarball/$(VENDOR)
	rm -rf $(SOURCE) cargo-home

download: download-crate
	@if [ -f ../tarball/$(VENDOR) ]; then \
		cp ../tarball/$(VENDOR) .; \
	elif [ -n "$(VENDOR_URL)" ]; then \
		$(CURL) $(VENDOR_URL) -o $(VENDOR); \
	else \
		$(MAKE) vendor-bundle; \
	fi

verify: verify-crate
	@if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256_VENDOR)  $(VENDOR)" | sha256sum -c -; else echo "$(SHA256_VENDOR)  $(VENDOR)" | shasum -a 256 -c -; fi

extract:
	rm -rf $(SOURCE) $(TARGET) $(STAGE) cargo-home
	mkdir -p $(SOURCE)/.cargo
	tar -xf $(CRATE) -C $(SOURCE) --strip-components 1
	zstd -dc $(VENDOR) | tar -xf - -C $(SOURCE)
	cp src/cargo-config.toml $(SOURCE)/.cargo/config.toml

binary:
	@test "$$(uname -s)" = Linux || (echo "cargo-pgrx must be compiled in a Linux builder" >&2; exit 1)
	@test "$$(uname -m)" = "$(RARCH)" || (echo "builder architecture $$(uname -m) does not match $(RARCH)" >&2; exit 1)
	@test -x "$(RUST_ROOT)/bin/cargo" || (echo "missing $(RUST_ROOT); install rust-toolchain first" >&2; exit 1)
	@test "$$($(RUST_ROOT)/bin/rustc --version | awk '{print $$2}')" = "$(RUST_BUILD_VERSION)" || (echo "rustc $(RUST_BUILD_VERSION) is required to build this artifact" >&2; exit 1)
	cd $(SOURCE) && \
		PATH="$(RUST_ROOT)/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
		CARGO_HOME="$(CURDIR)/cargo-home" \
		CARGO_TARGET_DIR="$(CURDIR)/$(TARGET)" \
		CARGO_INCREMENTAL=0 \
		CARGO_PROFILE_RELEASE_STRIP=symbols \
		SOURCE_DATE_EPOCH=$(SOURCE_DATE_EPOCH) \
		RUSTFLAGS="--remap-path-prefix=$(CURDIR)/$(SOURCE)=/usr/src/debug/$(PACKAGE)-$(VERSION) -C link-arg=-Wl,--build-id=sha1" \
		"$(RUST_ROOT)/bin/cargo" build --release --frozen --no-default-features
	mkdir -p $(STAGE)$(PREFIX)/bin $(STAGE)/usr/share/doc/$(PACKAGE)
	install -m 0755 $(TARGET)/release/cargo-pgrx $(STAGE)$(PREFIX)/bin/cargo-pgrx
	@test "$$($(STAGE)$(PREFIX)/bin/cargo-pgrx pgrx --version)" = "cargo-pgrx $(VERSION)"
	src/check-abi.sh $(STAGE)$(PREFIX)/bin/cargo-pgrx $(GLIBC_FLOOR) $(GCC_FLOOR) $(STAGE)/usr/share/doc/$(PACKAGE)/ELF-ABI.txt

legal:
	mkdir -p $(STAGE)/usr/share/doc/$(PACKAGE) $(STAGE)/usr/share/man/man1
	cp $(SOURCE)/Cargo.lock $(STAGE)/usr/share/doc/$(PACKAGE)/Cargo.lock
	gzip -9n -c src/cargo-pgrx-0192.1 > $(STAGE)/usr/share/man/man1/cargo-pgrx-0192.1.gz
	cd $(SOURCE) && PATH="$(RUST_ROOT)/bin:$$PATH" CARGO_HOME="$(CURDIR)/cargo-home" "$(RUST_ROOT)/bin/cargo" metadata --locked --offline --no-default-features --format-version 1 > $(CURDIR)/$(STAGE)/usr/share/doc/$(PACKAGE)/CARGO-METADATA.json
	jq -r '.packages | sort_by(.name, .version)[] | [.name, .version, (.license // ""), (.license_file // ""), (.source // "workspace")] | @tsv' $(STAGE)/usr/share/doc/$(PACKAGE)/CARGO-METADATA.json > $(STAGE)/usr/share/doc/$(PACKAGE)/THIRD-PARTY-METADATA.tsv
	@test "$$(jq '[.packages[] | select((.license == null or .license == "") and (.license_file == null or .license_file == ""))] | length' $(STAGE)/usr/share/doc/$(PACKAGE)/CARGO-METADATA.json)" = 0 || (echo "dependency without license metadata" >&2; exit 1)
	src/generate-licenses.sh $(SOURCE)/vendor $(STAGE)/usr/share/doc/$(PACKAGE)/THIRD-PARTY-LICENSES.txt
	@{ \
		echo "package=$(PACKAGE)"; \
		echo "version=$(VERSION)"; \
		echo "release=$(RELEASE)"; \
		echo "target=$(RARCH)-unknown-linux-gnu"; \
		echo "rustc=$$($(RUST_ROOT)/bin/rustc --version)"; \
		echo "cargo=$$($(RUST_ROOT)/bin/cargo --version)"; \
		echo "crate=$(CRATE)"; \
		echo "crate_sha256=$(SHA256_CRATE)"; \
		echo "vendor=$(VENDOR)"; \
		echo "vendor_sha256=$(SHA256_VENDOR)"; \
		echo "glibc_floor=$(GLIBC_FLOOR)"; \
		echo "gcc_floor=$(GCC_FLOOR)"; \
	} > $(STAGE)/usr/share/doc/$(PACKAGE)/BUILDINFO

clean:
	rm -rf $(SOURCE) $(TARGET) $(STAGE) cargo-home $(CRATE) $(VENDOR) $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link download-crate verify-crate vendor-bundle download verify extract binary legal clean build rpm deb one
