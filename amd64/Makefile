#==============================================================#
# File      :   Makefile
# Ctime     :   2023-10-05
# Mtime     :   2024-08-24
# Desc      :   Makefile shortcuts for prometheus amd64 build
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#

default: build
build: dir all
all: loki prometheus alertmanager pushgateway blackbox_exporter \
	node_exporter nginx_exporter keepalived_exporter mysqld_exporter mongodb_exporter kafka_exporter \
	pg_exporter redis_exporter pgbackrest_exporter victoria-metrics pg_timetable duckdb etcd ferretdb \
	kafka sqlcmd tigerbeetle
dir:
	mkdir -p ../dist/deb.amd64 ../dist/rpm.x86_64

loki:
	cd loki && make
prometheus:
	cd prometheus && make
pushgateway:
	cd pushgateway && make
alertmanager:
	cd alertmanager && make
blackbox_exporter:
	cd blackbox_exporter && make
nginx_exporter:
	cd nginx_exporter && make
node_exporter:
	cd node_exporter && make
keepalived_exporter:
	cd keepalived_exporter && make
pgbackrest_exporter:
	cd pgbackrest_exporter && make
mysqld_exporter:
	cd mysqld_exporter && make
redis_exporter:
	cd redis_exporter && make
kafka_exporter:
	cd kafka_exporter && make
mongodb_exporter:
	cd mongodb_exporter && make
victoria-metrics:
	cd victoria-metrics && make
duckdb:
	cd duckdb && make
etcd:
	cd etcd && make
pg_timetable:
	cd pg_timetable && make
ferretdb:
	cd ferretdb && make
sqlcmd:
	cd sqlcmd && make
tigerbeetle:
	cd tigerbeetle && make
kafka:
	cd kafka && make
v2ray:
	cd v2ray && make

ds: grafana-infinity-ds grafana-victoriametrics-ds grafana-victorialogs-ds
grafana-infinity-ds:
	cd grafana-infinity-ds && make

grafana-victoriametrics-ds:
	cd grafana-victoriametrics-ds && make

grafana-victorialogs-ds:
	cd grafana-victorialogs-ds && make

.PHONY: all build loki prometheus alertmanager pushgateway blackbox_exporter \
	node_exporter nginx_exporter keepalived_exporter mysqld_exporter mongodb_exporter \
	kafka_exporter pg_exporter redis_exporter pgbackrest_exporter \
	victoria-metrics pg_timetable duckdb etcd ferretdb sqlcmd tigerbeetle kafka v2ray \
	ds grafana-infinity-ds grafana-victoriametrics-ds grafana-victorialogs-ds