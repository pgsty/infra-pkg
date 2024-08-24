#==============================================================#
# File      :   Makefile
# Desc      :   pgsty/pkg repo shortcuts
# Ctime     :   2024-07-28
# Mtime     :   2024-07-28
# Path      :   Makefile
# Author    :   Ruohang Feng (rh@vonng.com)
# License   :   AGPLv3
#==============================================================#

DEVEL_PATH = sv:/data/pgsty/infra-pkg

###############################################################
#                        1. Building                          #
###############################################################
all: amd64 arm64
amd64:
	cd amd64 && make
arm64:
	cd arm64 && make


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

###############################################################
#                         Inventory                           #
###############################################################
.PHONY: all amd64 arm64 push pushd pull pulld