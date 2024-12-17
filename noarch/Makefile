#==============================================================#
# File      :   Makefile
# Ctime     :   2023-10-05
# Mtime     :   2024-12-16
# Desc      :   Makefile shortcuts for prometheus arm64 build
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#

all: grafana-extra victorialogs-datasource victoriametrics-datasource

ge: grafana-extra
grafana-extra:
	cd grafana-extra && make

vlds: victorialogs-datasource
victorialogs-datasource:
	cd victorialogs-datasource && make

vmds: victoriametrics-datasource
victoriametrics-datasource:
	cd victoriametrics-datasource && make

.PHONY: all ge vlds vmds grafana-extra victorialogs-datasource victoriametrics-datasource