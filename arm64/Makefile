#==============================================================#
# File      :   Makefile
# Ctime     :   2023-10-05
# Mtime     :   2024-07-28
# Desc      :   Makefile shortcuts for prometheus arm64 build
# Path      :   Makefile
# Copyright (C) 2018-2024 Ruohang Feng (rh@vonng.com)
#==============================================================#

default: build
build: dir all
all: loki prometheus alertmanager pushgateway blackbox_exporter \
	node_exporter nginx_exporter keepalived_exporter mysqld_exporter mongodb_exporter kafka_exporter \
	pg_exporter redis_exporter pgbackrest_exporter victoria-metrics pg_timetable duckdb etcd ferretdb \
	sqlcmd tigerbeetle
dir:
	mkdir -p ../dist/deb.arm64 ../dist/rpm.aarch64

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
v2ray:
	cd v2ray && make

all: loki prometheus alertmanager pushgateway blackbox_exporter node_exporter nginx_exporter keepalived_exporter mysqld_exporter mongodb_exporter kafka_exporter pg_exporter redis_exporter pgbackrest_exporter victoria-metrics pg_timetable duckdb etcd ferretdb sqlcmd tigerbeetle v2ray

.PHONY: all build loki prometheus alertmanager pushgateway blackbox_exporter node_exporter nginx_exporter keepalived_exporter mysqld_exporter mongodb_exporter kafka_exporter pg_exporter redis_exporter pgbackrest_exporter victoria-metrics pg_timetable duckdb etcd ferretdb sqlcmd tigerbeetle v2ray