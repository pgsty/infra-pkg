# infra-pkg: build rpm/deb for observability stack

Building Infra RPM & DEB packages for [Pigsty](https://pgsty.com).

Collected and distributed by [pgsty/pkg](https://github.com/pgsty/pkg) project.


--------

## What's inside?

Prometheus & Grafana Stack RPM & DEB for `amd64`(`x86_64`) & `arm64`(`aarch64`).

**Building From Tarball**:

- [prometheus](https://github.com/prometheus/prometheus) : 3.1.0
- [pushgateway](https://github.com/prometheus/pushgateway) : 1.11.0
- [alertmanager](https://github.com/prometheus/alertmanager) : 0.28.0
- [blackbox_exporter](https://github.com/prometheus/blackbox_exporter) : 0.25.0
- [nginx_exporter](https://github.com/nginxinc/nginx-prometheus-exporter) : 1.4.1
- [node_exporter](https://github.com/prometheus/node_exporter) : 1.8.2
- [keepalived_exporter](https://github.com/mehdy/keepalived-exporter) : 1.4.0
- [pgbackrest_exporter](https://github.com/woblerr/pgbackrest_exporter) 0.19.0
- [mysqld_exporter](https://github.com/prometheus/mysqld_exporter) : 0.16.0
- [redis_exporter](https://github.com/oliver006/redis_exporter) : 1.67.0
- [kafka_exporter](https://github.com/danielqsj/kafka_exporter) : 1.8.0
- [mongodb_exporter](https://github.com/percona/mongodb_exporter) : 0.43.1
- [VictoriaMetrics](https://github.com/VictoriaMetrics/VictoriaMetrics) : 1.111.0
- [VictoriaLogs](https://github.com/VictoriaMetrics/VictoriaMetrics/releases) : 1.9.1
- [duckdb](https://github.com/duckdb/duckdb) : 1.2.0
- [etcd](https://github.com/etcd-io/etcd) : 3.5.18
- [pg_timetable](https://github.com/cybertec-postgresql/pg_timetable): 5.11.0
- [ferretdb](https://github.com/FerretDB/FerretDB): 1.24.0
- [tigerbeetle](https://github.com/tigerbeetle/tigerbeetle) 0.16.27
- [loki](https://github.com/grafana/loki) : 3.1.1
- [promtail](https://github.com/grafana/loki/releases/tag/v3.0.0) : 3.0.0 (3.1.1 fail on el7/el8)


**Download Directly**:

- [grafana](https://github.com/grafana/grafana/) : 11.4.0
    - RPM amd64 & arm64: https://mirrors.tuna.tsinghua.edu.cn/grafana/yum/rpm/Packages/
      - https://mirrors.tuna.tsinghua.edu.cn/grafana/yum/rpm/Packages/grafana-11.5.1-1.aarch64.rpm
      - https://mirrors.tuna.tsinghua.edu.cn/grafana/yum/rpm/Packages/grafana-11.5.1-1.x86_64.rpm
    - DEB amd64 & arm64: https://mirrors.tuna.tsinghua.edu.cn/grafana/apt/pool/main/g/grafana/
      - https://mirrors.tuna.tsinghua.edu.cn/grafana/apt/pool/main/g/grafana/grafana_11.5.1_amd64.deb
      - https://mirrors.tuna.tsinghua.edu.cn/grafana/apt/pool/main/g/grafana/grafana_11.5.1_arm64.deb
- [**pg_exporter**](https://github.com/Vonng/pg_exporter) : 0.7.1
    - amd64 & arm64: https://github.com/Vonng/pg_exporter/releases
- [vector](https://github.com/vectordotdev/vector/releases) : 0.44.0
    - amd64 & arm64: https://packages.timber.io/vector/latest/
- [vip-manager](https://github.com/cybertec-postgresql/vip-manager): 3.0.0
    - amd64 & arm64: https://github.com/cybertec-postgresql/vip-manager/releases/tag/v3.0.0
- [minio](https://github.com/minio/minio): 20250207232109
    - amd64: https://dl.min.io/server/minio/release/linux-amd64/
    - arm64: https://dl.min.io/server/minio/release/linux-arm64/
- [mcli](https://github.com/minio/mc): 20250208191421
    - amd64: https://dl.min.io/client/mc/release/linux-amd64/
    - arm64: https://dl.min.io/client/mc/release/linux-arm64/
- [sealos](https://github.com/labring/sealos): 5.0.1
    - amd64 & arm64: https://github.com/labring/sealos/releases/tag/v5.0.1
- [rclone](https://github.com/rclone/rclone/releases/) 1.69.0


--------

## Changelog

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

```bash
git add amd64/nginx_exporter      arm64/nginx_exporter       ; git commit -m 'bump nginx_exporter to the latest version'                                            
git add amd64/pgbackrest_exporter arm64/pgbackrest_exporter  ; git commit -m 'bump pgbackrest_exporter to the latest version'                                                 
git add amd64/redis_exporter      arm64/redis_exporter       ; git commit -m 'bump redis_exporter to the latest version'                                            
git add amd64/mongodb_exporter    arm64/mongodb_exporter     ; git commit -m 'bump mongodb_exporter to the latest version'                                              
git add amd64/pushgateway         arm64/pushgateway          ; git commit -m 'bump pushgateway to the latest version'                                         
git add amd64/alertmanager        arm64/alertmanager         ; git commit -m 'bump alertmanager to the latest version'                                          
git add amd64/tigerbeetle         arm64/tigerbeetle          ; git commit -m 'bump tigerbeetle to the latest version'                                         
git add amd64/victoria-metrics    arm64/victoria-metrics     ; git commit -m 'bump victoria-metrics to the latest version'                                              
git add amd64/duckdb              arm64/duckdb               ; git commit -m 'bump duckdb to the latest version'                                    
git add amd64/etcd                arm64/etcd                 ; git commit -m 'bump etcd to the latest version'                                  
git add amd64/pg_timetable        arm64/pg_timetable         ; git commit -m 'bump pg_timetable to the latest version'                                          
git add amd64/ferretdb            arm64/ferretdb             ; git commit -m 'bump ferretdb to the latest version'                                      
```


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
