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
VERSION=3.1.1
RELEASE_PAGE=https://github.com/$(REPONAME)/releases/v$(VERSION)
DIRNAME="$(PACKAGE)-$(VERSION).linux-amd64"

FILENAME1=logcli-linux-amd64.zip
FILENAME2=loki-canary-linux-amd64.zip
FILENAME3=loki-linux-amd64.zip
FILENAME4=promtail-linux-amd64.zip

WEB_URL1=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME1)
WEB_URL2=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME2)
WEB_URL3=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME3)
WEB_URL4=https://github.com/$(REPONAME)/releases/download/v$(VERSION)/$(FILENAME4)


default: all
all: download extract build clean
get: download extract

# print download link and download command
link:
	@echo $(REPONAME) $(VERSION) on $(RELEASE_PAGE)
	@echo curl -SL $(WEB_URL1) -o $(FILENAME1); fi
	@echo curl -SL $(WEB_URL2) -o $(FILENAME2); fi
	@echo curl -SL $(WEB_URL3) -o $(FILENAME3); fi
	@echo curl -SL $(WEB_URL4) -o $(FILENAME4); fi

# get latest release info
meta:
	curl --silent "https://api.github.com/repos/${REPONAME}/releases/latest" | tee meta.json

# download latest release tarball to current directory
# if already in ../tarball/ , just copy it
download:
	if [ -f ../tarball/$(FILENAME1) ]; then cp ../tarball/$(FILENAME1) .; else curl -SL $(WEB_URL1) -o $(FILENAME1); fi
	if [ -f ../tarball/$(FILENAME2) ]; then cp ../tarball/$(FILENAME2) .; else curl -SL $(WEB_URL2) -o $(FILENAME2); fi
	if [ -f ../tarball/$(FILENAME3) ]; then cp ../tarball/$(FILENAME3) .; else curl -SL $(WEB_URL3) -o $(FILENAME3); fi
	if [ -f ../tarball/$(FILENAME4) ]; then cp ../tarball/$(FILENAME4) .; else curl -SL $(WEB_URL4) -o $(FILENAME4); fi

# extract tarball content to current directory
extract:
	mkdir -p $(PACKAGE)
	cp -f $(FILENAME1) $(FILENAME2) $(FILENAME3) $(FILENAME4) $(PACKAGE)/
	cd $(PACKAGE) && unzip $(FILENAME1) && unzip $(FILENAME2) && unzip $(FILENAME3) && unzip $(FILENAME4)

# remove tarball, build dir, rpm & deb files
clean:
	rm -rf $(PACKAGE) $(PACKAGE)*.rpm $(PACKAGE)*.deb loki*.zip promtail*.zip logcli*.zip

# build rpm & deb package
build: rpm deb
rpm:
	nfpm package --config loki-rpm.yaml     --packager rpm --target ../../dist/rpm.x86_64/
	nfpm package --config logcli.yaml       --packager rpm --target ../../dist/rpm.x86_64/
	nfpm package --config promtail-rpm.yaml --packager rpm --target ../../dist/rpm.x86_64/
deb:
	nfpm package --config loki-deb.yaml     --packager deb --target ../../dist/deb.amd64/
	nfpm package --config logcli.yaml       --packager deb --target ../../dist/deb.amd64/
	nfpm package --config promtail-deb.yaml --packager deb --target ../../dist/deb.amd64/

.PHONY: all get link meta download extract clean build rpm deb