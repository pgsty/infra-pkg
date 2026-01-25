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
VERSION=1.134.0

RELEASE_PAGE=https://github.com/$(REPONAME)/releases/v$(VERSION)
FILENAME1=victoria-metrics-linux-arm64-v$(VERSION).tar.gz
FILENAME2=victoria-metrics-linux-arm64-v$(VERSION)-cluster.tar.gz
FILENAME3=vmutils-linux-arm64-v$(VERSION).tar.gz

WEB_URL1=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME1)
WEB_URL2=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME2)
WEB_URL3=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME3)


default: all
all: download extract build clean
get: download extract

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo curl -SL $(WEB_URL1) -o $(FILENAME1)
	@echo curl -SL $(WEB_URL2) -o $(FILENAME2)
	@echo curl -SL $(WEB_URL3) -o $(FILENAME3)

# get latest release info
meta:
	curl --silent "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

# download latest release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME1) ]; then cp ../tarball/$(FILENAME1) .; else curl -SL $(WEB_URL1) -o $(FILENAME1); fi
	if [ -f ../tarball/$(FILENAME2) ]; then cp ../tarball/$(FILENAME2) .; else curl -SL $(WEB_URL2) -o $(FILENAME2); fi
	if [ -f ../tarball/$(FILENAME3) ]; then cp ../tarball/$(FILENAME3) .; else curl -SL $(WEB_URL3) -o $(FILENAME3); fi

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
	nfpm package --config victoria-metrics.yaml         --packager rpm --target ../../dist/rpm.aarch64/
	nfpm package --config victoria-metrics-cluster.yaml --packager rpm --target ../../dist/rpm.aarch64/
	nfpm package --config vmutils.yaml                  --packager rpm --target ../../dist/rpm.aarch64/

deb:
	nfpm package --config victoria-metrics.yaml         --packager deb --target ../../dist/deb.arm64/
	nfpm package --config victoria-metrics-cluster.yaml --packager deb --target ../../dist/deb.arm64/
	nfpm package --config vmutils.yaml                  --packager deb --target ../../dist/deb.arm64/

.PHONY: all get link meta download extract clean build rpm deb