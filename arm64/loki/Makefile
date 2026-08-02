#==============================================================#
# File      :   Makefile
# Ctime     :   2023-10-05
# Mtime     :   2024-01-30
# Desc      :   Makefile shortcuts for rpm building
# Path      :   Makefile
# Copyright (C) 2018-2023 Ruohang Feng (rh@vonng.com)
#==============================================================#
REPONAME="grafana/loki"
PACKAGE="loki"
# Obsolete: keep Loki/logcli/promtail frozen at 3.6.7.
VERSION=3.6.7
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/tag/v$(VERSION)
DIRNAME="$(PACKAGE)-$(VERSION).linux-arm64"

FILENAME1=logcli-linux-arm64.zip
FILENAME2=loki-linux-arm64.zip
FILENAME3=promtail-linux-arm64.zip
SHA256_1=88eb1939c1a45f72ae31e65124317c77d4f84b371d3fd27db1ba782c33542bcd
SHA256_2=94cbc2ce398c7056f0bbaa38cfb22e7ebfa081d66baf8472373e2abf5c363f30
SHA256_3=25a154fe2dd6708c1215b978014630d9dd040c061ebb46bad6c69b6cf88a2e27

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

# get selected release info
meta:
	curl --fail --silent --show-error "https://api.github.com/repos/${REPONAME}/releases/tags/v$(VERSION)" | tee meta.json

# download latest release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME1) ]; then cp ../tarball/$(FILENAME1) .; else curl -fSL $(WEB_URL1) -o $(FILENAME1); fi
	if [ -f ../tarball/$(FILENAME2) ]; then cp ../tarball/$(FILENAME2) .; else curl -fSL $(WEB_URL2) -o $(FILENAME2); fi
	if [ -f ../tarball/$(FILENAME3) ]; then cp ../tarball/$(FILENAME3) .; else curl -fSL $(WEB_URL3) -o $(FILENAME3); fi

verify:
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256_1)  $(FILENAME1)" | sha256sum -c -; else echo "$(SHA256_1)  $(FILENAME1)" | shasum -a 256 -c -; fi
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256_2)  $(FILENAME2)" | sha256sum -c -; else echo "$(SHA256_2)  $(FILENAME2)" | shasum -a 256 -c -; fi
	if command -v sha256sum >/dev/null 2>&1; then echo "$(SHA256_3)  $(FILENAME3)" | sha256sum -c -; else echo "$(SHA256_3)  $(FILENAME3)" | shasum -a 256 -c -; fi

# extract tarball content to current directory
extract:
	rm -rf $(PACKAGE)
	mkdir -p $(PACKAGE)
	cp -f $(FILENAME1) $(FILENAME2) $(FILENAME3) $(PACKAGE)/
	cd $(PACKAGE) && unzip -o $(FILENAME1) && unzip -o $(FILENAME2) && unzip -o $(FILENAME3)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(PACKAGE)*.rpm $(PACKAGE)*.deb loki*.zip promtail*.zip logcli*.zip

# build rpm & deb package
build: rpm deb
rpm:
	mkdir -p ../../dist/rpm.aarch64/
	../../bin/nfpm package --config loki.yaml --packager rpm --target ../../dist/rpm.aarch64/
	../../bin/nfpm package --config logcli.yaml --packager rpm --target ../../dist/rpm.aarch64/
	../../bin/nfpm package --config promtail.yaml --packager rpm --target ../../dist/rpm.aarch64/
deb:
	mkdir -p ../../dist/deb.arm64/
	../../bin/nfpm package --config loki.yaml --packager deb --target ../../dist/deb.arm64/
	../../bin/nfpm package --config logcli.yaml --packager deb --target ../../dist/deb.arm64/
	../../bin/nfpm package --config promtail.yaml --packager deb --target ../../dist/deb.arm64/

.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb
