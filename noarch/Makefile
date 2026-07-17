#==============================================================#
# File      :   Makefile
# Ctime     :   2023-10-05
# Mtime     :   2026-07-16
# Desc      :   Makefile shortcuts for prometheus arm64 build
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#

all: grafana-plugins jmx-exporter pev2

gp: grafana-plugins
grafana-plugins:
	cd grafana-plugins && make

jmx-exporter:
	cd jmx-exporter && make

pev2:
	cd pev2 && make


.PHONY: all ge grafana-plugins jmx-exporter pev2
