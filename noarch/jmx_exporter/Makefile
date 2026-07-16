#==============================================================#
# File      :   Makefile
# Ctime     :   2026-07-16
# Mtime     :   2026-07-16
# Desc      :   Makefile shortcuts for jmx_exporter rpm/deb build
# Path      :   Makefile
# Copyright (C) 2018-2026 Ruohang Feng (rh@vonng.com)
#==============================================================#
PACKAGE=jmx_exporter
VERSION=1.6.0
FILENAME=jmx_prometheus_javaagent-$(VERSION).jar
CHECKSUM_FILE=$(FILENAME).sha256
SHA256=a95983fd96e865d2bcdf911cc500e7c82808c27ab9fd226bf96732b6c3d8c46e
RELEASE_PAGE=https://github.com/prometheus/jmx_exporter/releases/tag/v$(VERSION)
WEB_URL=https://github.com/prometheus/jmx_exporter/releases/download/v$(VERSION)/$(FILENAME)
CHECKSUM_URL=$(WEB_URL).sha256
CURL=curl -fSL --retry 3


default: all
all: download verify build clean
get: download verify

# print release and download links
link:
	@echo $(PACKAGE) $(VERSION) on $(RELEASE_PAGE)
	@echo $(CURL) $(WEB_URL) -o $(FILENAME)
	@echo $(CURL) $(CHECKSUM_URL) -o $(CHECKSUM_FILE)

# copy versioned artifacts from the shared cache, or fetch them from upstream
download:
	if [ -f ../tarball/$(FILENAME) ]; then cp ../tarball/$(FILENAME) .; else $(CURL) $(WEB_URL) -o $(FILENAME); fi
	if [ -f ../tarball/$(CHECKSUM_FILE) ]; then cp ../tarball/$(CHECKSUM_FILE) .; else $(CURL) $(CHECKSUM_URL) -o $(CHECKSUM_FILE); fi

# pin the upstream checksum and validate the JAR archive before packaging
verify:
	test "$$(awk '{print $$1}' $(CHECKSUM_FILE))" = "$(SHA256)"
	if command -v sha256sum >/dev/null 2>&1; then sha256sum -c $(CHECKSUM_FILE); else shasum -a 256 -c $(CHECKSUM_FILE); fi
	unzip -tq $(FILENAME)

# remove copied inputs and local package artifacts
clean:
	rm -f $(FILENAME) $(CHECKSUM_FILE) $(PACKAGE)*.rpm $(PACKAGE)*.deb

# build one architecture-independent rpm and deb package
build: rpm deb
rpm:
	mkdir -p ../../dist/noarch/
	nfpm package --config nfpm-rpm.yaml --packager rpm --target ../../dist/noarch/
deb:
	mkdir -p ../../dist/noarch/
	nfpm package --config nfpm-deb.yaml --packager deb --target ../../dist/noarch/


.PHONY: all get link download verify clean build rpm deb
