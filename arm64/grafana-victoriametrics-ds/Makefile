#==============================================================#
# File      :   Makefile
# Ctime     :   2024-07-25
# Mtime     :   2026-01-16
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME2=VictoriaMetrics/victoriametrics-datasource
PACKAGE2=victoriametrics-metrics-datasource
VERSION2=0.25.2
FILENAME2=$(PACKAGE2)-v$(VERSION2).tar.gz
WEB_URL2=https://github.com/$(REPONAME2)/releases/download/v$(VERSION2)/$(FILENAME2)
SHA2562=14738de0b76b76aaafc3ce743c1a9dfee613a09b0864eef9f528ef3c036ae33d

default: all
all: download verify extract build clean
get: download verify extract

# print download link and download command
link:
	@echo curl -fSL --retry 3 $(WEB_URL2) -o $(FILENAME2)

# download latest release tarball to current directory
download:
	if [ -f ../tarball/$(FILENAME2) ]; then cp ../tarball/$(FILENAME2) .; else curl -fSL --retry 3 $(WEB_URL2) -o $(FILENAME2); fi

# verify cached or downloaded input before extraction
verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA2562)  $(FILENAME2)" | sha256sum -c -; else echo "$(SHA2562)  $(FILENAME2)" | shasum -a 256 -c -; fi

# extract tarball content to current directory
extract:
	tar -xf $(FILENAME2)
	# keep only the target backend; the pruned package is intentionally unsigned
	for suffix in darwin_amd64 darwin_arm64 freebsd_amd64 linux_arm linux_amd64 linux_s390x openbsd_amd64 windows_amd64.exe; do rm -f "$(PACKAGE2)/victoriametrics_metrics_backend_plugin_$$suffix"; done
	rm -f $(PACKAGE2)/MANIFEST.txt
	test -x $(PACKAGE2)/victoriametrics_metrics_backend_plugin_linux_arm64

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE2) $(FILENAME2) $(PACKAGE2)*.rpm $(PACKAGE2)*.deb

# build rpm & deb package
build: rpm deb
rpm:
	../../bin/nfpm package --config nfpm.yaml --packager rpm --target ../../dist/rpm.aarch64/
deb:
	../../bin/nfpm package --config nfpm.yaml --packager deb --target ../../dist/deb.arm64/

.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb
