#==============================================================#
# File      :   Makefile
# Ctime     :   2024-07-25
# Mtime     :   2025-10-02
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME2=VictoriaMetrics/victoriametrics-datasource
PACKAGE2=victoriametrics-metrics-datasource
VERSION2=0.19.4
FILENAME2=$(PACKAGE2)-v$(VERSION2).tar.gz
WEB_URL2=https://github.com/$(REPONAME2)/releases/download/v$(VERSION2)/$(FILENAME2)

default: all
all: download extract build clean
get: download extract

# download latest release tarball to current directory
download:
	if [ -f ../tarball/$(FILENAME2) ]; then cp ../tarball/$(FILENAME2) .; else curl -SL $(WEB_URL2) -o $(FILENAME2); fi

# extract tarball content to current directory
extract:
	tar -xf $(FILENAME2)
	rm -rf $(PACKAGE2)/victoriametrics_metrics_backend_plugin_{darwin_amd64,darwin_arm64,linux_386,linux_arm,linux_amd64,linux_s390x,windows_amd64.exe} #linux_arm64

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE2) $(FILENAME2) $(PACKAGE2)*.rpm $(PACKAGE2)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	nfpm package --config nfpm.yaml --packager rpm --target ../../dist/rpm.aarch64/
deb:
	nfpm package --config nfpm.yaml --packager deb --target ../../dist/deb.arm64/


.PHONY: all get link meta download extract clean build rpm deb