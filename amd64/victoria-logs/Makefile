#==============================================================#
# File      :   Makefile
# Ctime     :   2025-07-16
# Mtime     :   2025-10-02
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2023 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME=VictoriaMetrics/VictoriaLogs
PACKAGE=victoria-logs
VERSION=1.35.0
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/v$(VERSION)
FILENAME1=victoria-logs-linux-amd64-v$(VERSION).tar.gz
FILENAME2=vlutils-linux-amd64-v$(VERSION).tar.gz
WEB_URL1=https://github.com/$(REPONAME)/releases/download/v$(VERSION)-victorialogs/$(FILENAME1)
WEB_URL2=https://github.com/$(REPONAME)/releases/download/v$(VERSION)-victorialogs/$(FILENAME2)


default: all
all: download extract build clean
get: download extract

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo curl -SL $(WEB_URL1) -o $(FILENAME1)
	@echo curl -SL $(WEB_URL2) -o $(FILENAME2)

# get latest release info
meta:
	curl --silent "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

# download latest release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME1) ]; then cp ../tarball/$(FILENAME1) .; else curl -SL $(WEB_URL1) -o $(FILENAME1); fi
	if [ -f ../tarball/$(FILENAME2) ]; then cp ../tarball/$(FILENAME2) .; else curl -SL $(WEB_URL2) -o $(FILENAME2); fi

# extract tarball content to current directory
extract:
	mkdir -p $(PACKAGE)
	tar -xf $(FILENAME1)  -C $(PACKAGE)
	tar -xf $(FILENAME2)  -C $(PACKAGE)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(FILENAME1) $(FILENAME2)

# build rpm & deb package
build: rpm deb
rpm:
	nfpm package --config victoria-logs.yaml  --packager rpm --target ../../dist/rpm.x86_64/
	nfpm package --config vlogscli.yaml       --packager rpm --target ../../dist/rpm.x86_64/
	nfpm package --config vlagent.yaml        --packager rpm --target ../../dist/rpm.x86_64/

deb:
	nfpm package --config victoria-logs.yaml  --packager deb --target ../../dist/deb.amd64/
	nfpm package --config vlogscli.yaml       --packager deb --target ../../dist/deb.amd64/
	nfpm package --config vlagent.yaml        --packager deb --target ../../dist/deb.amd64/

.PHONY: all get link meta download extract clean build rpm deb