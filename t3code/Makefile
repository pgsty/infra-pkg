# Upstream publishes DEB only. Preserve it and repackage its payload as RPM.
ARCH  ?= amd64
ARCHS ?= amd64 arm64
RARCH  = $(if $(filter arm64,$(ARCH)),aarch64,x86_64)
export ARCH RARCH

VENDOR_DEB=1
PACKAGE=t3code
VERSION=0.1.11
PROXY ?= http://127.0.0.1:8888
CURL=curl -fSL --retry 3 --proxy "$(PROXY)"

DEB_FILE_amd64=T3-Code-0.1.11-amd64.deb
DEB_URL_amd64=https://github.com/pingdotgg/t3code/releases/download/v0.1.11/T3-Code-0.1.11-amd64.deb
SHA256_DEB_amd64=ccd43f67f95ff416ddf76f31a876b8cb0ca64e7df7343deb5b5941936384e1d0
DEB_FILE_arm64=T3-Code-0.1.11-arm64.deb
DEB_URL_arm64=https://github.com/pingdotgg/t3code/releases/download/v0.1.11/T3-Code-0.1.11-arm64.deb
SHA256_DEB_arm64=3b02c131ec122f02e65cc901beb7d644e7160a1763b2fb4ac12f1b296ed1870f
DEB_FILE=$(DEB_FILE_$(ARCH))
DEB_URL=$(DEB_URL_$(ARCH))
SHA256_DEB=$(SHA256_DEB_$(ARCH))

default: all
all:
	@set -e; for a in $(ARCHS); do $(MAKE) ARCH=$$a one; done
one: download verify extract build clean
get: download verify extract

link:
	@echo $(CURL) $(DEB_URL) -o $(DEB_FILE)

download:
	@if [ -f ../tarball/$(DEB_FILE) ]; then cp ../tarball/$(DEB_FILE) .; else $(CURL) $(DEB_URL) -o $(DEB_FILE).part && mv $(DEB_FILE).part $(DEB_FILE); fi

verify:
	@if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256_DEB)  $(DEB_FILE)" | sha256sum -c -; else echo "$(SHA256_DEB)  $(DEB_FILE)" | shasum -a 256 -c -; fi
	@test "$$(dpkg-deb -f $(DEB_FILE) Package)" = "$(PACKAGE)"
	@test "$$(dpkg-deb -f $(DEB_FILE) Version)" = "$(VERSION)"
	@test "$$(dpkg-deb -f $(DEB_FILE) Architecture)" = "$(ARCH)"

extract:
	rm -rf payload
	dpkg-deb -x $(DEB_FILE) payload
	# Declare the SUID sandbox mode in RPM metadata, not a postinstall chmod.
	mv 'payload/opt/T3 Code (Beta)/chrome-sandbox' payload/chrome-sandbox

build: rpm deb
rpm:
	../bin/nfpm package --config nfpm.yaml --packager rpm --target ../dist/rpm/
deb:
	mkdir -p ../dist/deb
	cp -p $(DEB_FILE) ../dist/deb/$(PACKAGE)_$(VERSION)_$(ARCH).deb

verify-dist:
	@if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256_DEB)  ../dist/deb/$(PACKAGE)_$(VERSION)_$(ARCH).deb" | sha256sum -c -; else echo "$(SHA256_DEB)  ../dist/deb/$(PACKAGE)_$(VERSION)_$(ARCH).deb" | shasum -a 256 -c -; fi

clean:
	rm -rf payload $(DEB_FILE) $(DEB_FILE).part

.NOTPARALLEL:
.PHONY: default all one get link download verify extract build rpm deb verify-dist clean
