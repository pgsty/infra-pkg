#==============================================================#
# File      :   Makefile
# Ctime     :   2025-12-25
# Mtime     :   2026-01-16
# Desc      :   Makefile shortcuts for asciinema rpm/deb building
# Path      :   Makefile
# Copyright (C) 2018-2025 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
ASCIINEMA_DEB_LIBC_arm64=libc6 (>= 2.18)
ASCIINEMA_DEB_LIBGCC_arm64=libgcc-s1 | libgcc1
ASCIINEMA_RPM_LIBC_arm64=glibc >= 2.18
ASCIINEMA_RPM_LIBGCC_arm64=libgcc
ASCIINEMA_DEB_LIBC=$(ASCIINEMA_DEB_LIBC_$(ARCH))
ASCIINEMA_DEB_LIBGCC=$(ASCIINEMA_DEB_LIBGCC_$(ARCH))
ASCIINEMA_RPM_LIBC=$(ASCIINEMA_RPM_LIBC_$(ARCH))
ASCIINEMA_RPM_LIBGCC=$(ASCIINEMA_RPM_LIBGCC_$(ARCH))
export ARCH RARCH
export ASCIINEMA_DEB_LIBC ASCIINEMA_DEB_LIBGCC ASCIINEMA_RPM_LIBC ASCIINEMA_RPM_LIBGCC

REPONAME=asciinema/asciinema
PACKAGE=asciinema
VERSION=3.2.1
RELEASE=1PGSTY
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
FILENAME_amd64=$(PACKAGE)-x86_64-unknown-linux-musl
FILENAME_arm64=$(PACKAGE)-aarch64-unknown-linux-gnu
FILENAME=$(FILENAME_$(ARCH))
SHA256_amd64=bec9781bc8f297a9d3d74ff60205599507f2abba1183578b8b2f22be4c999214
SHA256_arm64=b516a6d896844c0ffbc96e0a55afe4cbcc79216abde0fc64fdda4e39bee421ea
SHA256=$(SHA256_$(ARCH))
WEB_URL=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME)
CURL=curl -fSL --retry 3

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract build clean
get: download verify extract

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)

# get latest release info
meta:
	curl --fail --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

# download binary to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

# verify the official release binary before packaging
verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256)  $(FILENAME)" | shasum -a 256 -c -; fi
	test -s $(FILENAME)

# stage the architecture-specific binary under a stable packaging path
extract:
	mkdir -p $(PACKAGE)
	cp $(FILENAME) $(PACKAGE)/$(PACKAGE)
	chmod +x $(PACKAGE)/$(PACKAGE)

# remove binary, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb one
