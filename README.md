# infra-pkg: build rpm/deb for observability stack

Building Infra RPM & DEB packages for [Pigsty](https://pigsty.io).

Available in pigsty-infra [**YUM**](http://pigsty.io/ext/repo/yum) & [**APT**](http://pigsty.io/ext/repo/apt) repo

--------

## What's inside?

Prometheus & Grafana Stack RPM & DEB for `amd64`(`x86_64`) & `arm64`(`aarch64`).

**Building From Tarball**:

- [prometheus](https://github.com/prometheus/prometheus) : 3.4.0
- [pushgateway](https://github.com/prometheus/pushgateway) : 1.11.1
- [alertmanager](https://github.com/prometheus/alertmanager) : 0.28.1
- [blackbox_exporter](https://github.com/prometheus/blackbox_exporter) : 0.26.0
- [nginx_exporter](https://github.com/nginxinc/nginx-prometheus-exporter) : 1.4.2
- [node_exporter](https://github.com/prometheus/node_exporter) : 1.9.1
- [zfs_exporter](https://github.com/waitingsong/zfs_exporter/releases/) : 3.8.1
- [keepalived_exporter](https://github.com/mehdy/keepalived-exporter) : 1.6.2
- [pgbackrest_exporter](https://github.com/woblerr/pgbackrest_exporter) 0.20.0
- [mysqld_exporter](https://github.com/prometheus/mysqld_exporter) : 0.17.2
- [redis_exporter](https://github.com/oliver006/redis_exporter) : 1.72.1
- [kafka_exporter](https://github.com/danielqsj/kafka_exporter) : 1.9.0
- [mongodb_exporter](https://github.com/percona/mongodb_exporter) : 0.44.0
- [VictoriaMetrics](https://github.com/VictoriaMetrics/VictoriaMetrics) : 1.117.1
- [VictoriaLogs](https://github.com/VictoriaMetrics/VictoriaMetrics/releases) : 1.22.2
- [duckdb](https://github.com/duckdb/duckdb) : 1.3.0
- [etcd](https://github.com/etcd-io/etcd) : 3.6.0
- [mtail](https://github.com/google/mtail) : 3.0.8
- [restic](https://github.com/restic/restic) : 0.18.0
- [juicefs](https://github.com/juicedata/juicefs) : 1.2.3
- [pg_timetable](https://github.com/cybertec-postgresql/pg_timetable): 5.13.0
- [ferretdb](https://github.com/FerretDB/FerretDB): 2.2.0
- [tigerbeetle](https://github.com/tigerbeetle/tigerbeetle) 0.16.41
- [loki](https://github.com/grafana/loki) : 3.1.1
- [promtail](https://github.com/grafana/loki/releases/tag/v3.0.0) : 3.0.0 (3.1.1 fail on el7/el8)
- [grafana-victorialogs-ds](https://github.com/VictoriaMetrics/victorialogs-datasource/releases/) 0.16.3
- [grafana-victoriametrics-ds](https://github.com/VictoriaMetrics/victoriametrics-datasource/releases/) 0.15.1
- [grafana-infinity-ds](https://github.com/grafana/grafana-infinity-datasource/) 3.2.1
- [kafka](https://kafka.apache.org/downloads) 4.0.0


**Download Directly**:

- [grafana](https://github.com/grafana/grafana/) : 12.0.0
    - RPM amd64 & arm64: https://mirrors.tuna.tsinghua.edu.cn/grafana/yum/rpm/Packages/
      - https://mirrors.tuna.tsinghua.edu.cn/grafana/yum/rpm/Packages/grafana-12.0.0-1.aarch64.rpm
      - https://mirrors.tuna.tsinghua.edu.cn/grafana/yum/rpm/Packages/grafana-12.0.0-1.x86_64.rpm
    - DEB amd64 & arm64: https://mirrors.tuna.tsinghua.edu.cn/grafana/apt/pool/main/g/grafana/
      - https://mirrors.tuna.tsinghua.edu.cn/grafana/apt/pool/main/g/grafana/grafana_12.0.0_amd64.deb
      - https://mirrors.tuna.tsinghua.edu.cn/grafana/apt/pool/main/g/grafana/grafana_12.0.0_arm64.deb
- [pg_exporter](https://github.com/Vonng/pg_exporter) : 1.0.0
    - amd64 & arm64: https://github.com/Vonng/pg_exporter/releases
- [vector](https://github.com/vectordotdev/vector/releases) : 0.47.0
    - amd64 & arm64: https://packages.timber.io/vector/latest/
- [vip-manager](https://github.com/cybertec-postgresql/vip-manager): 3.0.0
    - amd64 & arm64: https://github.com/cybertec-postgresql/vip-manager/releases/tag/v3.0.0
- [minio](https://github.com/minio/minio): 20250422221226
    - amd64: https://dl.min.io/server/minio/release/linux-amd64/
    - arm64: https://dl.min.io/server/minio/release/linux-arm64/
- [mcli](https://github.com/minio/mc): 20250416181326
    - amd64: https://dl.min.io/client/mc/release/linux-amd64/
    - arm64: https://dl.min.io/client/mc/release/linux-arm64/
- [sealos](https://github.com/labring/sealos): 5.0.1
    - amd64 & arm64: https://github.com/labring/sealos/releases/tag/v5.0.1
- [rclone](https://github.com/rclone/rclone/releases/) 1.69.3


--------

## Changelog

**2025-05-22**

- [x] prometheus 3.4.0
- [x] duckdb 1.3.0
- [x] etcd 3.6.0
- [x] pg_exporter 1.0.0
- [x] ferretdb 2.2.0
- [x] rclone 1.69.3
- [x] minio 20250422221226
- [x] mcli 20250416181326
- [x] nginx_exporter 1.4.2
- [x] keepalived_exporter 1.6.2
- [x] pgbackrest_exporter 0.20.0
- [x] redis_exporter 1.27.1
- [x] victoriametrics 1.117.1
- [x] victorialogs 1.22.2
- [x] pg_timetable 5.13.0
- [x] tigerbeetle 0.16.41
- [x] pev2 1.15.0
- [x] grafana 12.0.0
- [x] grafana-victorialogs-ds 0.16.3
- [x] grafana-victoriametrics-ds 0.15.1
- [x] grafana-infinity-ds 3.2.1
- [x] grafana_plugins 12.0.0


**2025-04-23**

- mtail 3.0.8 (new)
- pig 0.4.0
- pg_exporter 0.9.0
- prometheus 3.3.0
- pushgateway 1.11.1
- keepalived_exporter 1.6.0
- redis_exporter 1.70.0
- victoriametrics 1.115.0
- victoria_logs 1.20.0
- duckdb 1.2.2
- pg_timetable 5.12.0
- vector 0.46.1
- minio 20250422221226
- mcli 20250416181326


**2025-04-05**

- pig 0.3.4
- etcd 3.5.21
- restic 0.18.0
- ferretdb 2.1.0
- tigerbeetle 0.16.34
- pg_exporter 0.8.1
- node_exporter 1.9.1
- grafana 11.6.0
- zfs_exporter 3.8.1
- mongodb_exporter 0.44.0
- victoriametrics 1.114.0
- minio 20250403145628
- mcli 20250403170756

**2025-03-23**

- etcd 3.5.20
- pgbackrest_exporter 0.19.0 rebuild
- victorialogs 1.17.0
- vslogcli 1.17.0


**2025-03-17**

- kafka 4.0.0
- Prometheus 3.2.1
- AlertManager 0.28.1
- blackbox_exporter 0.26.0
- node_exporter 1.9.0
- mysqld_exporter 0.17.2
- kafka_exporter 1.9.0
- redis_exporter 1.69.0
- DuckDB 1.2.1
- etcd 3.5.19
- FerretDB 2.0.0
- tigerbeetle 0.16.31
- vector 0.45.0
- VictoriaMetrics 1.114.0
- VictoriaLogs 1.16.0
- rclone 1.69.1
- pev2 1.14.0
- grafana-victorialogs-ds 0.16.0
- grafana-victoriametrics-ds 0.14.0
- grafana-infinity-ds 3.0.0
- +timescaledb-event-streamer 0.12.0
- +restic 0.17.3
- +juicefs 1.2.3

**2025-02-12**

- pushgateway 1.10.0 -> 1.11.0
- alertmanager 0.27.0 -> 0.28.0
- nginx_exporter 1.4.0 -> 1.4.1
- pgbackrest_exporter 0.18.0 -> 0.19.0
- redis_exporter 1.66.0 -> 1.67.0
- mongodb_exporter 0.43.0 -> 0.43.1
- VictoriaMetrics 1.107.0 -> 1.111.0
- VictoriaLogs v1.3.2 -> 1.9.1
- DuckDB 1.1.3 -> 1.2.0
- Etcd 3.5.17 -> 3.5.18
- pg_timetable 5.10.0 -> 5.11.0
- FerretDB 1.24.0 -> 2.0.0
- tigerbeetle 0.16.13 -> 0.16.27
- grafana 11.4.0 -> 11.5.1
- vector 0.43.1 -> 0.44.0
- minio 20241218131544 -> 20250207232109
- mcli 20241121172154 -> 20250208191421
- rclone 1.68.2 -> 1.69.0


**2025-01-10**

- Prometheus 3.1.0

**2024-11-19**

- Prometheus: 2.54.0 -> 3.0.0
- VictoriaMetrics 1.102.1 -> 1.106.1
- VictoriaLogs v0.28.0 -> 1.0.0
- MySQL Exporter 0.15.1 -> 0.16.0
- Redis Exporter 1.62.0 -> 1.66.0
- MongoDB Exporter 0.41.2 -> 0.42.0
- Keepalived Exporter 1.3.3 -> 1.4.0
- DuckDB 1.1.2 -> 1.1.3
- etcd 3.5.16 -> 3.5.17
- tigerbeetle 16.8 -> 0.16.13
- grafana 11.3.0
- vector 0.42.0



--------

## License

Maintainer: Ruohang Feng / [@Vonng](https://vonng.com/en/) ([rh@vonng.com](mailto:rh@vonng.com))

License: [Apache 2.0](LICENSE)
