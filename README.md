# infra-pkg: build rpm/deb for observability stack

Building Infra RPM & DEB packages for [Pigsty](https://pigsty.io).

Collected and distributed by [pgsty/pkg](https://github.com/pgsty/pkg) project.


--------

## What's inside?

Prometheus & Grafana Stack RPM & DEB for `amd64`(`x86_64`) & `arm64`(`aarch64`).

**Building From Tarball**:

- [loki](https://github.com/grafana/loki) : 3.1.1
- [promtail](https://github.com/grafana/loki/releases/tag/v3.0.0) : 3.0.0 (3.1.1 fail on el7/el8)
- [prometheus](https://github.com/prometheus/prometheus) : 3.0.0
- [pushgateway](https://github.com/prometheus/pushgateway) : 1.10.0
- [alertmanager](https://github.com/prometheus/alertmanager) : 0.27.0
- [blackbox_exporter](https://github.com/prometheus/blackbox_exporter) : 0.25.0
- [nginx_exporter](https://github.com/nginxinc/nginx-prometheus-exporter) : 1.3.0
- [node_exporter](https://github.com/prometheus/node_exporter) : 1.8.2
- [keepalived_exporter](https://github.com/mehdy/keepalived-exporter) : 1.4.0
- [pgbackrest_exporter](https://github.com/woblerr/pgbackrest_exporter) 0.18.0
- [mysqld_exporter](https://github.com/prometheus/mysqld_exporter) : 0.16.0
- [redis_exporter](https://github.com/oliver006/redis_exporter) : v1.66.0
- [kafka_exporter](https://github.com/danielqsj/kafka_exporter) : 1.8.0
- [mongodb_exporter](https://github.com/percona/mongodb_exporter) : 0.41.2
- [VictoriaMetrics](https://github.com/VictoriaMetrics/VictoriaMetrics) : 1.106.1
- [VictoriaLogs](https://github.com/VictoriaMetrics/VictoriaMetrics/releases) : v1.0.0
- [duckdb](https://github.com/duckdb/duckdb) : 1.1.3
- [etcd](https://github.com/etcd-io/etcd) : 3.5.17
- [pg_timetable](https://github.com/cybertec-postgresql/pg_timetable): 5.9.0
- [ferretdb](https://github.com/FerretDB/FerretDB): 1.24.0
- [tigerbeetle](https://github.com/tigerbeetle/tigerbeetle) 0.16.13


**Download Directly**:

- [grafana](https://github.com/grafana/grafana/) : 11.2.2 (Download Directly)
    - RPM amd64 & arm64: https://mirrors.tuna.tsinghua.edu.cn/grafana/yum/rpm/Packages/
    - DEB amd64 & arm64: https://mirrors.tuna.tsinghua.edu.cn/grafana/apt/pool/main/g/grafana/
- [**pg_exporter**](https://github.com/Vonng/pg_exporter) : 0.7.0 (Maintained Separately)
    - amd64 & arm64: https://github.com/Vonng/pg_exporter/releases
- [vector](https://github.com/vectordotdev/vector/releases) : 0.42.0
    - amd64 & arm64: https://packages.timber.io/vector/latest/
- [vip-manager](https://github.com/cybertec-postgresql/vip-manager): 2.8.0
    - amd64 & arm64: https://github.com/cybertec-postgresql/vip-manager/releases/tag/v2.8.0
- [minio](https://github.com/minio/minio): 20241107005220
    - amd64: https://dl.min.io/server/minio/release/linux-amd64/
    - arm64: https://dl.min.io/server/minio/release/linux-arm64/
- [mcli](https://github.com/minio/mc): 20241117193525
    - amd64: https://dl.min.io/client/mc/release/linux-amd64/
    - arm64: https://dl.min.io/client/mc/release/linux-arm64/
- [sealos](https://github.com/labring/sealos): 5.0.1
    - amd64 & arm64: https://github.com/labring/sealos/releases/tag/v5.0.1

--------

## Changelog

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
