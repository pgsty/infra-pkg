#==============================================================#
# File      :   Makefile
# Ctime     :   2026-08-19
# Mtime     :   2026-08-19
# Desc      :   Current PGSTY Rust toolchain RPM/DEB package
# Path      :   rust-toolchain/Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
SOURCE_DATE_EPOCH=1788393600
export ARCH RARCH
export SOURCE_DATE_EPOCH

PACKAGE=rust-toolchain
VERSION=1.98.1
RELEASE=1PGSTY
DIST_DATE=2026-09-03
TRIPLE=$(RARCH)-unknown-linux-gnu
DIRNAME=rust-$(VERSION)-$(TRIPLE)
FILENAME=$(DIRNAME).tar.xz
SIGNATURE=$(FILENAME).asc
SHA256_amd64=5326b36c53de11d148c8f8dab6553a3d1006c2cfd32123683073fad3c302605b
SHA256_arm64=0b514a8cc1cbcd939bff0f151661fe58b6ea5c7a7f645a5098c69e32e8c1e0a2
SHA256=$(SHA256_$(ARCH))
RUST_KEY_FINGERPRINT=108F66205EAEB0AAA8DD5E1C85AB96E6FA1BE5FE
RUST_DIST_SERVER ?= https://static.rust-lang.org
WEB_URL=$(RUST_DIST_SERVER)/dist/$(DIST_DATE)/$(FILENAME)
SIGNATURE_URL=$(RUST_DIST_SERVER)/dist/$(DIST_DATE)/$(SIGNATURE)
PREFIX=/usr/lib/pgsty/rust
COMPONENTS=rustc,rust-std-$(TRIPLE),cargo,rustfmt-preview
GLIBC_FLOOR=2.17
GCC_FLOOR=4.2.0
export GLIBC_FLOOR GCC_FLOOR
CURL=curl --http1.1 --retry 5 --retry-delay 2 --retry-connrefused --continue-at - -fL


default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract check-elf build clean
get: download verify

link:
	@echo Rust $(VERSION) for $(TRIPLE)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)
	@echo $(CURL) $(SIGNATURE_URL) -o $(SIGNATURE)

download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi
	if [ -f ../tarball/$(SIGNATURE) ]; then cp ../tarball/$(SIGNATURE) .; else $(CURL) $(SIGNATURE_URL) -o $(SIGNATURE); fi

verify:
	@if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi
	@keydir=$$(mktemp -d); \
	chmod 0700 "$$keydir"; \
	pub_count=$$(GNUPGHOME="$$keydir" gpg --batch --show-keys --with-colons src/rust-key.gpg.ascii | awk -F: '$$1 == "pub" { count++ } END { print count + 0 }'); \
	test "$$pub_count" = 1 || { echo "Rust keyring must contain exactly one primary key, found $$pub_count" >&2; rm -rf "$$keydir"; exit 1; }; \
	fingerprint=$$(GNUPGHOME="$$keydir" gpg --batch --show-keys --with-colons src/rust-key.gpg.ascii | awk -F: '$$1 == "fpr" { print $$10; exit }'); \
	test "$$fingerprint" = "$(RUST_KEY_FINGERPRINT)" || { echo "unexpected Rust signing key fingerprint: $$fingerprint" >&2; rm -rf "$$keydir"; exit 1; }; \
	GNUPGHOME="$$keydir" gpg --batch --yes --dearmor --output "$$keydir/rust-keyring.gpg" src/rust-key.gpg.ascii; \
	gpgv --keyring "$$keydir/rust-keyring.gpg" $(SIGNATURE) $(FILENAME); \
	status=$$?; rm -rf "$$keydir"; exit $$status

extract:
	rm -rf $(DIRNAME) stage
	tar -xf $(FILENAME)
	$(CURDIR)/$(DIRNAME)/install.sh \
		--prefix=$(PREFIX) \
		--destdir=$(CURDIR)/stage \
		--components=$(COMPONENTS) \
		--disable-ldconfig
	rm -f stage$(PREFIX)/lib/rustlib/uninstall.sh stage$(PREFIX)/lib/rustlib/install.log
	mkdir -p stage/usr/share/doc/$(PACKAGE)/upstream stage/usr/share/man/man1
	mv stage$(PREFIX)/share/doc/* stage/usr/share/doc/$(PACKAGE)/upstream/
	rm -rf stage$(PREFIX)/share/man stage$(PREFIX)/share/zsh stage$(PREFIX)/share/doc stage$(PREFIX)/etc/bash_completion.d
	cp $(DIRNAME)/LICENSE-APACHE stage/usr/share/doc/$(PACKAGE)/
	cp $(DIRNAME)/LICENSE-MIT stage/usr/share/doc/$(PACKAGE)/
	cp $(DIRNAME)/COPYRIGHT stage/usr/share/doc/$(PACKAGE)/
	gzip -9n -c src/rust-toolchain.1 > stage/usr/share/man/man1/rust-toolchain.1.gz
	@{ \
		echo "package=$(PACKAGE)"; \
		echo "version=$(VERSION)"; \
		echo "release=$(RELEASE)"; \
		echo "target=$(TRIPLE)"; \
		echo "source=$(FILENAME)"; \
		echo "source_sha256=$(SHA256)"; \
		echo "source_date=$(DIST_DATE)"; \
		echo "signing_key=$(RUST_KEY_FINGERPRINT)"; \
		echo "glibc_floor=$(GLIBC_FLOOR)"; \
		echo "gcc_floor=$(GCC_FLOOR)"; \
	} > stage/usr/share/doc/$(PACKAGE)/BUILDINFO

check-elf:
	src/check-elf.sh stage$(PREFIX) $(GLIBC_FLOOR) $(GCC_FLOOR) stage/usr/share/doc/$(PACKAGE)/ELF-ABI.txt

clean:
	rm -rf rust-$(VERSION)-*-unknown-linux-gnu stage rust-$(VERSION)-*-unknown-linux-gnu.tar.xz rust-$(VERSION)-*-unknown-linux-gnu.tar.xz.asc $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link download verify extract check-elf clean build rpm deb one
