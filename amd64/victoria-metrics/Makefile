#==============================================================#
# File      :   Makefile
# Ctime     :   2023-10-05
# Mtime     :   2026-01-16
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2023 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME=VictoriaMetrics/VictoriaMetrics
PACKAGE=victoria-metrics
VERSION=1.148.0

RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
FILENAME1=victoria-metrics-linux-amd64-v$(VERSION).tar.gz
FILENAME2=victoria-metrics-linux-amd64-v$(VERSION)-cluster.tar.gz
FILENAME3=vmutils-linux-amd64-v$(VERSION).tar.gz
SHA2561=805fef95f7114173da531b1dd6187657a0637b74ebd4492dde5d7a522b6462e3
SHA2562=3c1794206601fd769656fc7cf42c12698f0db139af1bf43ddbff9510fe6b48f0
SHA2563=54c72a7f335d76a8229032ed3aec5f4934ccd547186750065ea11408458ea7b2

WEB_URL1=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME1)
WEB_URL2=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME2)
WEB_URL3=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME3)


default: all
all: download verify extract build clean
get: download verify extract

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo curl -fSL $(WEB_URL1) -o $(FILENAME1)
	@echo curl -fSL $(WEB_URL2) -o $(FILENAME2)
	@echo curl -fSL $(WEB_URL3) -o $(FILENAME3)

# get configured release info
meta:
	curl --fail --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/tags/v$(VERSION)" | tee meta.json

# download configured release tarballs to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME1) ]; then cp ../tarball/$(FILENAME1) .; else curl -fSL $(WEB_URL1) -o $(FILENAME1); fi
	if [ -f ../tarball/$(FILENAME2) ]; then cp ../tarball/$(FILENAME2) .; else curl -fSL $(WEB_URL2) -o $(FILENAME2); fi
	if [ -f ../tarball/$(FILENAME3) ]; then cp ../tarball/$(FILENAME3) .; else curl -fSL $(WEB_URL3) -o $(FILENAME3); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA2561)  $(FILENAME1)" | sha256sum -c -; else echo "$(SHA2561)  $(FILENAME1)" | shasum -a 256 -c -; fi
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA2562)  $(FILENAME2)" | sha256sum -c -; else echo "$(SHA2562)  $(FILENAME2)" | shasum -a 256 -c -; fi
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA2563)  $(FILENAME3)" | sha256sum -c -; else echo "$(SHA2563)  $(FILENAME3)" | shasum -a 256 -c -; fi

# extract tarball content to current directory
extract:
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME1)  -C $(PACKAGE)
	tar -xf $(FILENAME2)  -C $(PACKAGE)
	tar -xf $(FILENAME3)  -C $(PACKAGE)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME1) $(FILENAME2) $(FILENAME3)

# build rpm & deb package
build: rpm deb
rpm:
	../../bin/nfpm package --config victoria-metrics.yaml         --packager rpm --target ../../dist/rpm.x86_64/
	../../bin/nfpm package --config victoria-metrics-cluster.yaml --packager rpm --target ../../dist/rpm.x86_64/
	../../bin/nfpm package --config vmutils.yaml                  --packager rpm --target ../../dist/rpm.x86_64/

deb:
	../../bin/nfpm package --config victoria-metrics.yaml         --packager deb --target ../../dist/deb.amd64/
	../../bin/nfpm package --config victoria-metrics-cluster.yaml --packager deb --target ../../dist/deb.amd64/
	../../bin/nfpm package --config vmutils.yaml                  --packager deb --target ../../dist/deb.amd64/

.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb
