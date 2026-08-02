#==============================================================#
# File      :   Makefile
# Ctime     :   2024-07-25
# Mtime     :   2025-12-05
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME1=VictoriaMetrics/victorialogs-datasource
PACKAGE1=victoriametrics-logs-datasource
VERSION1=0.30.1
FILENAME1=$(PACKAGE1)-v$(VERSION1).tar.gz
WEB_URL1=https://github.com/$(REPONAME1)/releases/download/v$(VERSION1)/$(FILENAME1)
SHA2561=328e4fd2057de057e3646fdcfcefd43e62005b99b9677489fa64c77c26395946


default: all
all: download verify extract build clean
get: download verify extract

# print download link and download command
link:
	@echo curl -fSL --retry 3 $(WEB_URL1) -o $(FILENAME1)

# download latest release tarball to current directory
d: download
download:
	if [ -f ../tarball/$(FILENAME1) ]; then cp ../tarball/$(FILENAME1) .; else curl -fSL --retry 3 $(WEB_URL1) -o $(FILENAME1); fi

# verify cached or downloaded input before extraction
verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA2561)  $(FILENAME1)" | sha256sum -c -; else echo "$(SHA2561)  $(FILENAME1)" | shasum -a 256 -c -; fi

# extract tarball content to current directory
e: extract
extract:
	tar -xf $(FILENAME1)
	# keep only the target backend; the pruned package is intentionally unsigned
	for suffix in darwin_amd64 darwin_arm64 freebsd_amd64 linux_arm linux_amd64 linux_s390x windows_amd64.exe; do rm -f "$(PACKAGE1)/victoriametrics_logs_backend_plugin_$$suffix"; done
	rm -f $(PACKAGE1)/MANIFEST.txt
	test -x $(PACKAGE1)/victoriametrics_logs_backend_plugin_linux_arm64

de: download verify extract

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE1) $(FILENAME1) $(PACKAGE1)*.rpm $(PACKAGE1)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../../bin/nfpm package --config nfpm.yaml --packager rpm --target ../../dist/rpm.aarch64/
deb:
	../../bin/nfpm package --config nfpm.yaml --packager deb --target ../../dist/deb.arm64/

.NOTPARALLEL:

.PHONY: all get link meta d e de download verify extract clean build rpm deb
