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
DIRNAME="$(PACKAGE)-$(VERSION).linux-amd64"

FILENAME1=logcli-linux-amd64.zip
FILENAME2=loki-linux-amd64.zip
FILENAME3=promtail-linux-amd64.zip
SHA256_1=b68f02dbd3e85a4259770098247000794caceec27a24e7653152545e6faaae21
SHA256_2=e9737023c71bc4381f7ced90a197a17a5908c1cf1b136bd381165e07ed50b1ac
SHA256_3=330f97bf7ef7e97cc2e42649ce7299129ab09dbffe5a2f5c515188502220987c

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
	mkdir -p ../../dist/rpm.x86_64/
	../../bin/nfpm package --config loki.yaml --packager rpm --target ../../dist/rpm.x86_64/
	../../bin/nfpm package --config logcli.yaml --packager rpm --target ../../dist/rpm.x86_64/
	../../bin/nfpm package --config promtail.yaml --packager rpm --target ../../dist/rpm.x86_64/
deb:
	mkdir -p ../../dist/deb.amd64/
	../../bin/nfpm package --config loki.yaml --packager deb --target ../../dist/deb.amd64/
	../../bin/nfpm package --config logcli.yaml --packager deb --target ../../dist/deb.amd64/
	../../bin/nfpm package --config promtail.yaml --packager deb --target ../../dist/deb.amd64/

.NOTPARALLEL:

.PHONY: all get link meta download verify extract clean build rpm deb
