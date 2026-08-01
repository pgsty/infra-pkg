#==============================================================#
# File      :   Makefile
# Ctime     :   2023-10-05
# Mtime     :   2026-08-01
# Desc      :   Makefile shortcuts for noarch package builds
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#

all: grafana-plugins jmx-exporter pev2

dir:
	mkdir -p ../dist/noarch

gp: grafana-plugins
grafana-plugins: | dir
	cd grafana-plugins && make

jmx-exporter: | dir
	cd jmx-exporter && make

pev2: | dir
	cd pev2 && make


.PHONY: all dir gp grafana-plugins jmx-exporter pev2
