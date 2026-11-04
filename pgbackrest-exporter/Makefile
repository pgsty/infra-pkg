#==============================================================#
# File      :   Makefile
# Ctime     :   2023-10-05
# Mtime     :   2026-08-02
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2023 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=woblerr/pgbackrest_exporter
PACKAGE=pgbackrest_exporter
VERSION=0.25.0
# v0.25.0 has no upstream binary assets; build its vendored source offline.
SOURCE_COMMIT=4cf845c0bd1caad5d5b8f12b20513b68a4ee226a
SHA256_SOURCE=2f09cda98c672d23ab4a74b8aff39ead71129f790dfc1357a1e994b8fe2502e2
GO_VERSION=1.27.3
BUILD_DATE=2026-10-29T10:11:33Z
PROXY ?= http://127.0.0.1:8888
CURL=curl --proxy "$(PROXY)" -fSL --retry 3
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
FILENAME=pgbackrest-exporter-$(VERSION)-source.tar.gz
WEB_URL=https://codeload.github.com/$(REPONAME)/tar.gz/$(SOURCE_COMMIT)
LDFLAGS=-s -w -buildid= \
	-X github.com/prometheus/common/version.Version=$(VERSION) \
	-X github.com/prometheus/common/version.Branch=v$(VERSION) \
	-X github.com/prometheus/common/version.Revision=$(SOURCE_COMMIT) \
	-X github.com/prometheus/common/version.BuildDate=$(BUILD_DATE) \
	-X github.com/prometheus/common/version.BuildUser=pgsty


default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract compile build clean
get: download verify extract

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)

# get latest release info
meta:
	$(CURL) --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

# download latest release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256_SOURCE)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256_SOURCE)  $(FILENAME)" | shasum -a 256 -c -; fi

# extract tarball content to current directory
extract:
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME) --strip-components 1 -C $(PACKAGE)

compile:
	@test "$$(GOTOOLCHAIN=local go env GOVERSION)" = "go$(GO_VERSION)" || { echo "Go $(GO_VERSION) is required for reproducible builds" >&2; exit 1; }
	cd $(PACKAGE) && CGO_ENABLED=0 GOOS=linux GOARCH=$(ARCH) GOTOOLCHAIN=local GOPROXY=off GOSUMDB=off go build -mod=vendor -trimpath -buildvcs=false -ldflags '$(LDFLAGS)' -o $(PACKAGE) .

test: get
	cd $(PACKAGE) && TZ=UTC GOTOOLCHAIN=local GOPROXY=off GOSUMDB=off go test -mod=vendor -timeout=60s -count=1 ./...

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link meta download verify extract compile test clean build rpm deb one
