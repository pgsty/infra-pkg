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

# every top-level directory holding a Makefile is a package recipe target
PACKAGE_RECIPES := $(sort $(patsubst %/,%,$(dir $(wildcard */Makefile))))
# Keep the large air-gap image archives out of the default batch build.
ON_DEMAND_PKGS := k3s-images rust-toolchain cargo-pgrx-0191
PKGS := $(filter-out $(ON_DEMAND_PKGS),$(PACKAGE_RECIPES))

###############################################################
#                        1. Building                          #
###############################################################
default: all
all: $(PKGS)

# build one package (both architectures / noarch): make <pkg>
$(PACKAGE_RECIPES): | dir
	cd $@ && $(MAKE)

# build every package for a single architecture: make amd64 / make arm64
amd64 arm64: | dir
	@set -e; for p in $(PKGS); do \
		if grep -q '^one:' $$p/Makefile; then $(MAKE) -C $$p ARCH=$@ one; fi; \
	done

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
.PHONY: default all amd64 arm64 dir lint push pushd pull pulld $(PACKAGE_RECIPES)
