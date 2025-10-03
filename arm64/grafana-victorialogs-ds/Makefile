#==============================================================#
# File      :   Makefile
# Ctime     :   2024-07-25
# Mtime     :   2025-10-02
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME1=VictoriaMetrics/victorialogs-datasource
PACKAGE1=victoriametrics-logs-datasource
VERSION1=0.21.0
FILENAME1=$(PACKAGE1)-v$(VERSION1).tar.gz
WEB_URL1=https://github.com/$(REPONAME1)/releases/download/v$(VERSION1)/$(FILENAME1)


default: all
all: download extract build clean
get: download extract

# download latest release tarball to current directory
d: download
download:
	if [ -f ../tarball/$(FILENAME1) ]; then cp ../tarball/$(FILENAME1) .; else curl -SL $(WEB_URL1) -o $(FILENAME1); fi

# extract tarball content to current directory
e: extract
extract:
	tar -xf $(FILENAME1)
	rm -rf $(PACKAGE1)/victoriametrics_logs_backend_plugin_{freebsd_amd64,darwin_amd64,darwin_arm64,linux_386,linux_arm,linux_amd64,linux_s390x,windows_amd64.exe} #linux_amd64

de: download extract

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE1) $(FILENAME1) $(PACKAGE1)*.rpm $(PACKAGE1)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	nfpm package --config nfpm.yaml --packager rpm --target ../../dist/rpm.aarch64/
deb:
	nfpm package --config nfpm.yaml --packager deb --target ../../dist/deb.arm64/


.PHONY: all get link meta download extract clean build rpm deb