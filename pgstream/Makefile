#==============================================================#
# File      :   Makefile
# Ctime     :   2026-03-21
# Mtime     :   2026-03-21
# Desc      :   Makefile shortcuts for pgstream rpm/deb building
# Path      :   Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

REPONAME=xataio/pgstream
PACKAGE=pgstream
VERSION=1.6.0
TAG=v$(VERSION)
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/$(TAG)
# v1.6.0 has no upstream binaries. Pin the release commit and source archive.
SOURCE_COMMIT=97d7ab464f0accf6cf1373b3c3f7b328debae4b9
FILENAME=$(PACKAGE)-$(VERSION)-source.tar.gz
SHA256_SOURCE=765679852af40cc607935fb63f754172270c98f50369270ab689fe2cca22020c
WEB_URL=https://codeload.github.com/$(REPONAME)/tar.gz/$(SOURCE_COMMIT)
GO_VERSION=1.27.3
PROXY ?= http://127.0.0.1:8888
CURL=curl --proxy "$(PROXY)" -fSL --retry 5 --retry-all-errors --retry-delay 2
LDFLAGS=-s -w -buildid= -X github.com/xataio/pgstream/cmd.Version=$(VERSION)

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract deps compile build clean
get: download verify extract

link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)

meta:
	$(CURL) --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256_SOURCE)  $(FILENAME)" | sha256sum -c -; else echo "$(SHA256_SOURCE)  $(FILENAME)" | shasum -a 256 -c -; fi

extract:
	rm -rf source $(PACKAGE)
	mkdir -p source $(PACKAGE)
	tar -xf $(FILENAME) --strip-components 1 -C source

deps:
	@test "$$(GOTOOLCHAIN=local go env GOVERSION)" = "go$(GO_VERSION)" || { echo "Go $(GO_VERSION) is required" >&2; exit 1; }
	cd source && HTTP_PROXY="$(PROXY)" HTTPS_PROXY="$(PROXY)" http_proxy="$(PROXY)" https_proxy="$(PROXY)" GOTOOLCHAIN=local go mod download
	cd source && GOTOOLCHAIN=local GOPROXY=off GOSUMDB=off go mod verify

compile:
	cd source && CGO_ENABLED=0 GOOS=linux GOARCH=$(ARCH) GOTOOLCHAIN=local GOPROXY=off GOSUMDB=off go build -mod=readonly -trimpath -buildvcs=false -ldflags '$(LDFLAGS)' -o ../$(PACKAGE)/$(PACKAGE) .

clean:
	rm -rf source $(PACKAGE) $(FILENAME) $(PACKAGE)*.rpm $(PACKAGE)*.deb

build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	../bin/nfpm package --config nfpm.yaml --packager deb --target ../dist/deb/


.NOTPARALLEL:

.PHONY: all get link meta download verify extract deps compile clean build rpm deb one
