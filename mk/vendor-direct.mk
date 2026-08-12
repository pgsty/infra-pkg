# Shared implementation for packages already published by their vendor as
# native DEB/RPM artifacts. Recipe Makefiles provide filenames, URLs, and
# SHA256 values; this file preserves the downloaded bytes without repacking.

DEB_FILE = $(DEB_FILE_$(ARCH))
RPM_FILE = $(RPM_FILE_$(ARCH))
DEB_URL = $(DEB_URL_$(ARCH))
RPM_URL = $(RPM_URL_$(ARCH))
SHA256_DEB = $(SHA256_DEB_$(ARCH))
SHA256_RPM = $(SHA256_RPM_$(ARCH))
CURL = curl --fail --show-error --location --retry 3 --proxy $(PROXY)

download:
	@if [ -f ../tarball/$(DEB_FILE) ]; then \
		cp ../tarball/$(DEB_FILE) .; \
	else \
		$(CURL) $(DEB_URL) -o $(DEB_FILE).part; \
		mv $(DEB_FILE).part $(DEB_FILE); \
	fi
	@if [ -f ../tarball/$(RPM_FILE) ]; then \
		cp ../tarball/$(RPM_FILE) .; \
	else \
		$(CURL) $(RPM_URL) -o $(RPM_FILE).part; \
		mv $(RPM_FILE).part $(RPM_FILE); \
	fi

verify:
	@if command -v sha256sum >/dev/null 2>&1; then \
		printf '%s  %s\n%s  %s\n' "$(SHA256_DEB)" "$(DEB_FILE)" "$(SHA256_RPM)" "$(RPM_FILE)" | sha256sum -c -; \
	else \
		printf '%s  %s\n%s  %s\n' "$(SHA256_DEB)" "$(DEB_FILE)" "$(SHA256_RPM)" "$(RPM_FILE)" | shasum -a 256 -c -; \
	fi

build:
	mkdir -p ../dist/deb ../dist/rpm
	cp -p $(DEB_FILE) ../dist/deb/$(DEB_FILE)
	cp -p $(RPM_FILE) ../dist/rpm/$(RPM_FILE)

verify-dist:
	@if command -v sha256sum >/dev/null 2>&1; then \
		printf '%s  %s\n%s  %s\n' "$(SHA256_DEB)" "../dist/deb/$(DEB_FILE)" "$(SHA256_RPM)" "../dist/rpm/$(RPM_FILE)" | sha256sum -c -; \
	else \
		printf '%s  %s\n%s  %s\n' "$(SHA256_DEB)" "../dist/deb/$(DEB_FILE)" "$(SHA256_RPM)" "../dist/rpm/$(RPM_FILE)" | shasum -a 256 -c -; \
	fi

get: download verify

link:
	@echo $(PACKAGE) $(VERSION) $(ARCH)
	@echo $(CURL) $(DEB_URL) -o $(DEB_FILE)
	@echo $(CURL) $(RPM_URL) -o $(RPM_FILE)

clean:
	rm -f $(DEB_FILE) $(RPM_FILE) $(DEB_FILE).part $(RPM_FILE).part

.PHONY: download verify build verify-dist get link clean
