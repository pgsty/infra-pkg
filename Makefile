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
dir:
	mkdir -p dist dist/{rpm.x86_64,rpm.aarch64,deb.amd64,deb.arm64}


###############################################################
#                       3. Component                          #
###############################################################
duckdb:
	cd amd64/duckdb && make
	cd arm64/duckdb && make
etcd:
	cd amd64/etcd && make
	cd arm64/etcd && make
mtail:
	cd amd64/mtail && make
	cd arm64/mtail && make
pg_timetable:
	cd amd64/pg_timetable && make
	cd arm64/pg_timetable && make
ferretdb:
	cd amd64/ferretdb && make
	cd arm64/ferretdb && make
sqlcmd:
	cd amd64/sqlcmd && make
	cd arm64/sqlcmd && make
tigerbeetle:
	cd amd64/tigerbeetle && make
	cd arm64/tigerbeetle && make
v2ray:
	cd amd64/v2ray && make
	cd arm64/v2ray && make
juicefs:
	cd amd64/juicefs && make
	cd arm64/juicefs && make
restic:
	cd amd64/restic && make
	cd arm64/restic && make
dblab:
	cd amd64/dblab && make
	cd arm64/dblab && make
garage:
	cd amd64/garage && make
	cd arm64/garage && make
seaweedfs:
	cd amd64/seaweedfs && make
	cd arm64/seaweedfs && make
rustfs:
	cd amd64/rustfs && make
	cd arm64/rustfs && make
uv:
	cd amd64/uv && make
	cd arm64/uv && make
ccm:
	cd amd64/ccm && make
	cd arm64/ccm && make
asciinema:
	cd amd64/asciinema && make
	cd arm64/asciinema && make


loki:
	cd amd64/loki && make
	cd arm64/loki && make
prometheus:
	cd amd64/prometheus && make
	cd arm64/prometheus && make
pushgateway:
	cd amd64/pushgateway && make
	cd arm64/pushgateway && make
alertmanager:
	cd amd64/alertmanager && make
	cd arm64/alertmanager && make
blackbox_exporter:
	cd amd64/blackbox_exporter && make
	cd arm64/blackbox_exporter && make
nginx_exporter:
	cd amd64/nginx_exporter && make
	cd arm64/nginx_exporter && make
node_exporter:
	cd amd64/node_exporter && make
	cd arm64/node_exporter && make
zfs_exporter:
	cd amd64/zfs_exporter && make
	cd arm64/zfs_exporter && make
keepalived_exporter:
	cd amd64/keepalived_exporter && make
	cd arm64/keepalived_exporter && make
pgbackrest_exporter:
	cd amd64/pgbackrest_exporter && make
	cd arm64/pgbackrest_exporter && make
mysqld_exporter:
	cd amd64/mysqld_exporter && make
	cd arm64/mysqld_exporter && make
redis_exporter:
	cd amd64/redis_exporter && make
	cd arm64/redis_exporter && make
kafka_exporter:
	cd amd64/kafka_exporter && make
	cd arm64/kafka_exporter && make
mongodb_exporter:
	cd amd64/mongodb_exporter && make
	cd arm64/mongodb_exporter && make
victoria: victoria-metrics victoria-logs victoria-traces
victoria-metrics:
	cd amd64/victoria-metrics && make
	cd arm64/victoria-metrics && make
victoria-logs:
	cd amd64/victoria-logs && make
	cd arm64/victoria-logs && make
victoria-traces:
	cd amd64/victoria-traces && make
	cd arm64/victoria-traces && make
grafana_plugins:
	cd noarch/grafana_plugins && make

grafana-ds:  grafana-infinity-ds grafana-victoriametrics-ds grafana-victorialogs-ds
grafana-infinity-ds:
	cd amd64/grafana-infinity-ds && make
	cd arm64/grafana-infinity-ds && make
grafana-victoriametrics-ds:
	cd amd64/grafana-victoriametrics-ds && make
	cd arm64/grafana-victoriametrics-ds && make
grafana-victorialogs-ds:
	cd amd64/grafana-victorialogs-ds && make
	cd arm64/grafana-victorialogs-ds && make

timescaledb-tools:
	cd amd64/timescaledb-tools && make
	cd arm64/timescaledb-tools && make

timescaledb-event-streamer:
	cd amd64/timescaledb-event-streamer && make
	cd arm64/timescaledb-event-streamer && make

opencode:
	cd amd64/opencode && make
	cd arm64/opencode && make

###############################################################
#                         Inventory                           #
###############################################################
.PHONY: all amd64 arm64 push pushd pull pulld dir \
	loki prometheus alertmanager pushgateway blackbox_exporter \
	node_exporter zfs_exporter nginx_exporter keepalived_exporter mysqld_exporter mongodb_exporter \
	kafka_exporter pg_exporter redis_exporter pgbackrest_exporter \
	victoria-metrics victoria-logs pg_timetable duckdb etcd mtail ferretdb sqlcmd tigerbeetle kafka v2ray \
	ds grafana-infinity-ds grafana-victoriametrics-ds grafana-victorialogs-ds timescaledb-tools timescaledb-event-streamer \
	restic juicefs dblab garage seaweedfs rustfs uv ccm asciinema grafana_plugins opencode

