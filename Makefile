#==============================================================#
# File      :   Makefile
# Desc      :   pgsty/infra-pkg build shortcuts (single-tree layout)
# Ctime     :   2024-07-28
# Mtime     :   2026-08-04
# Path      :   Makefile
# Author    :   Ruohang Feng (rh@vonng.com)
# License   :   AGPLv3
#==============================================================#

DEVEL_PATH = sv:/data/pgsty/infra-pkg

# every top-level directory holding a Makefile is a package
PKGS := $(sort $(patsubst %/,%,$(dir $(wildcard */Makefile))))

###############################################################
#                        1. Building                          #
###############################################################
default: all
all: $(PKGS)

# build one package (both architectures / noarch): make <pkg>
$(PKGS): | dir
	cd $@ && $(MAKE)

# build every package for a single architecture: make amd64 / make arm64
amd64 arm64: | dir
	@set -e; for p in $(PKGS); do \
		if grep -q '^one:' $$p/Makefile; then $(MAKE) -C $$p ARCH=$@ one; fi; \
	done

# k3s airgap image packages are big and built on demand
k3s-images:
	cd k3s && $(MAKE) images

dir:
	mkdir -p dist/rpm dist/deb

lint:
	python3 bin/lint_specs.py


###############################################################
#                        2. Syncing                           #
###############################################################
push:
	rsync -avc ./ $(DEVEL_PATH)/
pushd:
	rsync -avc --delete ./ $(DEVEL_PATH)/
pull:
	rsync -avc $(DEVEL_PATH)/ ./
pulld:
	rsync -avc --delete $(DEVEL_PATH)/ ./


.NOTPARALLEL:
.PHONY: default all amd64 arm64 k3s-images dir lint push pushd pull pulld $(PKGS)
