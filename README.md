# infra-pkg: build rpm/deb for Pigsty Infra

Building Infra RPM & DEB packages for [Pigsty Infra](https://pigsty.io/docs/repo/infra).

- [Pigsty Infra Repo](https://pigsty.io/docs/repo/infra)
- [Infra Change List](https://pigsty.io/docs/repo/infra/list)
- [Infra Change Log](https://pigsty.io/docs/repo/infra/log)

Artifact available in [**pigsty-infra**](https://pigsty.io/docs/repo/infra) APT/DNF repo


--------

## What's inside?

Pigsty Infra RPM & DEB packages for `amd64`(`x86_64`) & `arm64`(`aarch64`).

**Building From Tarball**:

- [prometheus](https://github.com/prometheus/prometheus) : 3.13.1
- [pushgateway](https://github.com/prometheus/pushgateway) : 1.11.3
- [alertmanager](https://github.com/prometheus/alertmanager) : 0.33.1
- [blackbox-exporter](https://github.com/prometheus/blackbox_exporter) : 0.28.0
- [nginx-exporter](https://github.com/nginxinc/nginx-prometheus-exporter) : 1.5.1
- [node-exporter](https://github.com/prometheus/node_exporter) : 1.12.1
- [zfs-exporter](https://github.com/waitingsong/zfs_exporter/releases/) : 3.8.1
- [keepalived-exporter](https://github.com/mehdy/keepalived-exporter) : 1.7.1
- [pgbackrest-exporter](https://github.com/woblerr/pgbackrest_exporter) 0.23.0
- [pg-exporter](https://github.com/pgsty/pg_exporter) : 1.4.0
- [mysqld-exporter](https://github.com/prometheus/mysqld_exporter) : 0.19.0
- [redis-exporter](https://github.com/oliver006/redis_exporter) : 1.87.0
- [kafka-exporter](https://github.com/danielqsj/kafka_exporter) : 1.9.0
- [jmx-exporter](https://github.com/prometheus/jmx_exporter) : 1.6.0 (noarch)
- [mongodb-exporter](https://github.com/percona/mongodb_exporter) : 0.51.0
- [VictoriaMetrics](https://github.com/VictoriaMetrics/VictoriaMetrics) : 1.147.0
- [VictoriaLogs](https://github.com/VictoriaMetrics/VictoriaLogs) : 1.51.0
- [VictoriaTraces](https://github.com/VictoriaMetrics/VictoriaTraces) : 0.9.4
- [duckdb](https://github.com/duckdb/duckdb) : 1.5.4
- [etcd](https://github.com/etcd-io/etcd) : 3.7.0
- [k3s](https://github.com/k3s-io/k3s) : 1.36.2 (upstream v1.36.2+k3s1)
- [k3s-images](https://github.com/k3s-io/k3s/releases/tag/v1.36.2%2Bk3s1) : 1.36.2 (amd64/arm64 system images)
- [mtail](https://github.com/google/mtail) : 3.0.8
- [restic](https://github.com/restic/restic) : 0.19.1
- [juicefs](https://github.com/juicedata/juicefs) : 1.4.0
- [tigerfs](https://github.com/timescale/tigerfs) : 0.7.0
- [dblab](https://github.com/danvergara/dblab) 0.44.1
- [pgstream](https://github.com/xataio/pgstream) 1.2.0
- [sql-studio](https://github.com/frectonz/sql-studio) 0.1.51
- [rainfrog](https://github.com/achristmascarl/rainfrog) 0.3.20
- [pg_timetable](https://github.com/cybertec-postgresql/pg_timetable): 6.3.0
- [ferretdb](https://github.com/FerretDB/FerretDB): 2.7.0
- [tigerbeetle](https://github.com/tigerbeetle/tigerbeetle) 0.17.9
- [loki](https://github.com/grafana/loki) : 3.6.7 (obsolete, frozen)
- [promtail](https://github.com/grafana/loki/releases/tag/v3.6.7) : 3.6.7 (obsolete, frozen)
- [grafana-victorialogs-ds](https://github.com/VictoriaMetrics/victorialogs-datasource/releases/) 0.29.0
- [grafana-victoriametrics-ds](https://github.com/VictoriaMetrics/victoriametrics-datasource/releases/) 0.25.2
- [grafana-infinity-ds](https://github.com/grafana/grafana-infinity-datasource/) 3.8.0
- [grafana-plugins](https://github.com/pgsty/infra-pkg/tree/main/noarch/grafana-plugins) 13.0.0 (noarch)
- [kafka](https://kafka.apache.org/downloads) 4.3.1
- [caddy](https://github.com/caddyserver/caddy) 2.11.4
- [headscale](https://github.com/juanfont/headscale) 0.29.2
- [hugo](https://github.com/gohugoio/hugo) 0.164.0
- [seaweedfs](https://github.com/seaweedfs/seaweedfs) 4.39
- [garage](https://git.deuxfleurs.fr/Deuxfleurs/garage) 2.3.0
- [rustfs](https://github.com/rustfs/rustfs) 1.0.0-beta.9
- [xray](https://github.com/XTLS/Xray-core) 26.3.27
- [vray](https://github.com/v2fly/v2ray-core) 5.51.2
- [gost](https://github.com/ginuerzh/gost) 2.12.0
- [sabiql](https://github.com/riii111/sabiql) 1.14.0
- [timescaledb-tools](https://github.com/timescale/timescaledb-tune) 0.19.0
- [timescaledb-event-streamer](https://github.com/noctarius/timescaledb-event-streamer) 0.20.0
- [agentsview](https://github.com/kenn-io/agentsview) 0.38.1
- [claude](https://github.com/anthropics/claude-code) 2.1.211
- [codex](https://github.com/openai/codex) 0.144.4
- [stalwart](https://github.com/stalwartlabs/stalwart) 0.16.13
- [maddy](https://github.com/foxcpp/maddy) 0.9.5
- [genai-toolbox](https://github.com/googleapis/mcp-toolbox) 1.6.0 (external build)
- [npgsqlrest](https://github.com/NpgsqlRest/NpgsqlRest) 3.21.0
- [postgrest](https://github.com/PostgREST/postgrest) 14.15
- [sqlcmd](https://github.com/microsoft/go-sqlcmd) 1.10.0
- [asciinema](https://github.com/asciinema/asciinema) 3.2.1
- [opencode](https://github.com/anomalyco/opencode) 1.18.2
- [uv](https://github.com/astral-sh/uv) 0.11.29
- [golang](https://go.dev/dl/) 1.26.5
  - x86_64: https://go.dev/dl/go1.26.5.linux-amd64.tar.gz
  - arm64: https://go.dev/dl/go1.26.5.linux-arm64.tar.gz
- [nodejs](https://nodejs.org/en/download/) 24.18.0
  - x86_64: https://nodejs.org/dist/v24.18.0/node-v24.18.0-linux-x64.tar.xz
  - arm64: https://nodejs.org/dist/v24.18.0/node-v24.18.0-linux-arm64.tar.xz


**Download Directly**:

- [grafana](https://github.com/grafana/grafana/) : 13.1.0
  - deb amd64: https://dl.grafana.com/grafana/release/13.1.0/grafana_13.1.0_28013217238_linux_amd64.deb
  - deb arm64: https://dl.grafana.com/grafana/release/13.1.0/grafana_13.1.0_28013217238_linux_arm64.deb
  - rpm amd64: https://dl.grafana.com/grafana/release/13.1.0/grafana_13.1.0_28013217238_linux_amd64.rpm
  - rpm arm64: https://dl.grafana.com/grafana/release/13.1.0/grafana_13.1.0_28013217238_linux_arm64.rpm
  - upstream: https://grafana.com/grafana/download?edition=oss
- [vector](https://github.com/vectordotdev/vector/releases) : 0.57.0
  - deb amd64: https://packages.timber.io/vector/0.57.0/vector_0.57.0-1_amd64.deb
  - deb arm64: https://packages.timber.io/vector/0.57.0/vector_0.57.0-1_arm64.deb
  - rpm amd64: https://packages.timber.io/vector/0.57.0/vector-0.57.0-1.x86_64.rpm
  - rpm arm64: https://packages.timber.io/vector/0.57.0/vector-0.57.0-1.aarch64.rpm
- [vip-manager](https://github.com/cybertec-postgresql/vip-manager): 4.2.0
    - amd64 & arm64: https://github.com/cybertec-postgresql/vip-manager/releases/tag/v4.2.0
- [pg-hardstorage](https://github.com/cybertec-postgresql/pg_hardstorage): 1.0.10
  - deb amd64: https://github.com/cybertec-postgresql/pg_hardstorage/releases/download/v1.0.10/pg-hardstorage_1.0.10_amd64.deb
  - deb arm64: https://github.com/cybertec-postgresql/pg_hardstorage/releases/download/v1.0.10/pg-hardstorage_1.0.10_arm64.deb
  - rpm amd64: https://github.com/cybertec-postgresql/pg_hardstorage/releases/download/v1.0.10/pg-hardstorage-1.0.10-1.x86_64.rpm
  - rpm arm64: https://github.com/cybertec-postgresql/pg_hardstorage/releases/download/v1.0.10/pg-hardstorage-1.0.10-1.aarch64.rpm
- [pgschema](https://github.com/pgplex/pgschema): 1.12.0
  - deb amd64: https://github.com/pgplex/pgschema/releases/download/v1.12.0/pgschema_1.12.0_amd64.deb
  - deb arm64: https://github.com/pgplex/pgschema/releases/download/v1.12.0/pgschema_1.12.0_arm64.deb
  - rpm amd64: https://github.com/pgplex/pgschema/releases/download/v1.12.0/pgschema-1.12.0-1.x86_64.rpm
  - rpm arm64: https://github.com/pgplex/pgschema/releases/download/v1.12.0/pgschema-1.12.0-1.aarch64.rpm
- [crush](https://github.com/charmbracelet/crush): 0.85.0
  - deb amd64: https://github.com/charmbracelet/crush/releases/download/v0.85.0/crush_0.85.0_amd64.deb
  - deb arm64: https://github.com/charmbracelet/crush/releases/download/v0.85.0/crush_0.85.0_arm64.deb
  - rpm amd64: https://github.com/charmbracelet/crush/releases/download/v0.85.0/crush-0.85.0-1.x86_64.rpm
  - rpm arm64: https://github.com/charmbracelet/crush/releases/download/v0.85.0/crush-0.85.0-1.aarch64.rpm
- [minio](https://github.com/pgsty/minio): 20260618000000
  - deb amd64: https://github.com/pgsty/minio/releases/download/RELEASE.2026-06-18T00-00-00Z/minio_20260618000000.0.0_amd64.deb
  - deb arm64: https://github.com/pgsty/minio/releases/download/RELEASE.2026-06-18T00-00-00Z/minio_20260618000000.0.0_arm64.deb
  - rpm amd64: https://github.com/pgsty/minio/releases/download/RELEASE.2026-06-18T00-00-00Z/minio-20260618000000.0.0-1.x86_64.rpm
  - rpm arm64: https://github.com/pgsty/minio/releases/download/RELEASE.2026-06-18T00-00-00Z/minio-20260618000000.0.0-1.aarch64.rpm
- [mcli](https://github.com/pgsty/mc): 20260417000000
  - deb amd64: https://github.com/pgsty/mc/releases/download/RELEASE.2026-04-17T00-00-00Z/mcli_20260417000000.0.0_amd64.deb
  - deb arm64: https://github.com/pgsty/mc/releases/download/RELEASE.2026-04-17T00-00-00Z/mcli_20260417000000.0.0_arm64.deb
  - rpm amd64: https://github.com/pgsty/mc/releases/download/RELEASE.2026-04-17T00-00-00Z/mcli-20260417000000.0.0-1.x86_64.rpm
  - rpm arm64: https://github.com/pgsty/mc/releases/download/RELEASE.2026-04-17T00-00-00Z/mcli-20260417000000.0.0-1.aarch64.rpm
- [sealos](https://github.com/labring/sealos): 5.1.1
    - amd64 & arm64: https://github.com/labring/sealos/releases/tag/v5.1.1
- [rclone](https://github.com/rclone/rclone/releases/) 1.74.4
  - deb amd64: https://downloads.rclone.org/v1.74.4/rclone-v1.74.4-linux-amd64.deb
  - deb arm64: https://downloads.rclone.org/v1.74.4/rclone-v1.74.4-linux-arm64.deb
  - rpm amd64: https://downloads.rclone.org/v1.74.4/rclone-v1.74.4-linux-amd64.rpm
  - rpm arm64: https://downloads.rclone.org/v1.74.4/rclone-v1.74.4-linux-arm64.rpm
- [code](https://code.visualstudio.com/) 1.129.0
  - deb amd64: https://vscode.download.prss.microsoft.com/dbazure/download/stable/125df4672b8a6a34975303c6b0baa124e560a4f7/code_1.129.0-1784074987_amd64.deb
  - deb arm64: https://vscode.download.prss.microsoft.com/dbazure/download/stable/125df4672b8a6a34975303c6b0baa124e560a4f7/code_1.129.0-1784074986_arm64.deb
  - rpm amd64: https://vscode.download.prss.microsoft.com/dbazure/download/stable/125df4672b8a6a34975303c6b0baa124e560a4f7/code-1.129.0-1784075033.el8.x86_64.rpm
  - rpm arm64: https://vscode.download.prss.microsoft.com/dbazure/download/stable/125df4672b8a6a34975303c6b0baa124e560a4f7/code-1.129.0-1784075035.el8.aarch64.rpm
- [code-server](https://github.com/coder/code-server) 4.128.0
  - deb amd64: https://github.com/coder/code-server/releases/download/v4.128.0/code-server_4.128.0_amd64.deb
  - deb arm64: https://github.com/coder/code-server/releases/download/v4.128.0/code-server_4.128.0_arm64.deb
  - rpm amd64: https://github.com/coder/code-server/releases/download/v4.128.0/code-server-4.128.0-amd64.rpm
  - rpm arm64: https://github.com/coder/code-server/releases/download/v4.128.0/code-server-4.128.0-arm64.rpm
- [cloudflared](https://github.com/cloudflare/cloudflared) 2026.7.2
  - deb amd64: https://github.com/cloudflare/cloudflared/releases/download/2026.7.2/cloudflared-linux-amd64.deb
  - deb arm64: https://github.com/cloudflare/cloudflared/releases/download/2026.7.2/cloudflared-linux-arm64.deb
  - rpm amd64: https://github.com/cloudflare/cloudflared/releases/download/2026.7.2/cloudflared-linux-x86_64.rpm
  - rpm arm64: https://github.com/cloudflare/cloudflared/releases/download/2026.7.2/cloudflared-linux-aarch64.rpm
- [pev2](https://github.com/dalibo/pev2/releases) 1.22.0
  - https://github.com/dalibo/pev2/releases
- [pig](https://github.com/pgsty/pig) : 1.5.1
  - amd64 & arm64: https://github.com/pgsty/pig/releases
--------

## Changelog


**2026-07-19**

| Name              | Old | New    | Comment                                    |
|:------------------|:----|:-------|:-------------------------------------------|
| k3s               | -   | 1.36.2 | upstream `v1.36.2+k3s1`; amd64 and arm64   |
| k3s-images        | -   | 1.36.2 | matching system images; amd64 and arm64    |


**2026-07-16**

| Name             | Old      | New      | Comment                       |
|:-----------------|:---------|:---------|:------------------------------|
| jmx-exporter     | -        | 1.6.0    | new noarch package            |
| node_exporter    | 1.11.1   | 1.12.1   |                               |
| redis_exporter   | 1.86.0   | 1.87.0   |                               |
| etcd             | 3.6.13   | 3.7.0    |                               |
| dblab            | 0.43.0   | 0.44.1   |                               |
| pgstream         | 1.1.1    | 1.2.0    |                               |
| rainfrog         | 0.3.19   | 0.3.20   |                               |
| rustfs           | 1.0.0-b8 | 1.0.0-b9 | prerelease line               |
| agentsview       | 0.37.5   | 0.38.1   |                               |
| claude           | 2.1.206  | 2.1.211  | downloaded through 8118 proxy |
| codex            | 0.144.1  | 0.144.4  | release tag `rust-v0.144.4`   |
| stalwart         | 0.16.12  | 0.16.13  |                               |
| npgsqlrest       | 3.20.0   | 3.21.0   |                               |
| postgrest        | 14.14    | 14.15    |                               |
| opencode         | 1.17.18  | 1.18.2   |                               |
| uv               | 0.11.28  | 0.11.29  |                               |
| vector           | 0.56.0   | 0.57.0   | downloaded directly           |
| pg-hardstorage   | 1.0.8    | 1.0.10   | downloaded directly           |
| crush            | 0.84.0   | 0.85.0   | downloaded directly           |
| code             | 1.128.0  | 1.129.0  | downloaded directly           |
| code-server      | 4.127.0  | 4.128.0  | downloaded directly           |
| cloudflared      | 2026.7.1 | 2026.7.2 | downloaded directly           |


**2026-07-10**

| Name        | Old      | New      | Comment                       |
|:------------|:---------|:---------|:------------------------------|
| prometheus  | 3.13.0   | 3.13.1   |                               |
| seaweedfs   | 4.38     | 4.39     |                               |
| agentsview  | 0.36.1   | 0.37.5   |                               |
| claude      | 2.1.204  | 2.1.206  | downloaded through 8118 proxy |
| codex       | 0.143.0  | 0.144.1  | release tag `rust-v0.144.1`   |
| npgsqlrest  | 3.19.0   | 3.20.0   |                               |
| opencode    | 1.17.15  | 1.17.18  |                               |
| crush       | 0.82.0   | 0.84.0   | downloaded directly           |
| rclone      | 1.74.3   | 1.74.4   | downloaded directly           |
| cloudflared | 2026.6.1 | 2026.7.1 | downloaded directly           |


**2026-07-08**

| Name                       | Old     | New     | Comment |
|:---------------------------|:--------|:--------|:--------|
| pg-hardstorage             | -       | 1.0.8   |         |
| alertmanager               | 0.33.0  | 0.33.1  |         |
| VictoriaMetrics            | 1.146.0 | 1.147.0 |         |
| restic                     | 0.19.0  | 0.19.1  |         |
| juicefs                    | 1.3.1   | 1.4.0   |         |
| dblab                      | 0.42.1  | 0.43.0  |         |
| pgstream                   | 1.1.0   | 1.1.1   |         |
| tigerbeetle                | 0.17.8  | 0.17.9  |         |
| grafana-victoriametrics-ds | 0.25.1  | 0.25.2  |         |
| hugo                       | 0.163.3 | 0.164.0 |         |
| seaweedfs                  | 4.37    | 4.38    |         |
| v2ray                      | 5.49.0  | 5.51.2  |         |
| sabiql                     | 1.13.0  | 1.14.0  |         |
| claude                     | 2.1.201 | 2.1.204 |         |
| codex                      | 0.142.5 | 0.143.0 |         |
| stalwart                   | 0.16.11 | 0.16.12 |         |
| opencode                   | 1.17.13 | 1.17.15 |         |
| uv                         | 0.11.26 | 0.11.28 |         |
| golang                     | 1.26.4  | 1.26.5  |         |
| pgschema                   | 1.11.1  | 1.12.0  |         |
| crush                      | 0.81.0  | 0.82.0  |         |
| code                       | 1.127.0 | 1.128.0 |         |
| pig                        | 1.5.0   | 1.5.1   |         |


**2026-07-04**

| Name                       | Old     | New     | Comment                                 |
|:---------------------------|:--------|:--------|:----------------------------------------|
| prometheus                 | 3.12.0  | 3.13.0  |                                         |
| VictoriaTraces             | 0.9.3   | 0.9.4   |                                         |
| etcd                       | 3.6.12  | 3.6.13  |                                         |
| dblab                      | 0.42.0  | 0.42.1  |                                         |
| grafana-victoriametrics-ds | 0.25.0  | 0.25.1  |                                         |
| headscale                  | 0.29.1  | 0.29.2  |                                         |
| seaweedfs                  | 4.35    | 4.37    |                                         |
| agentsview                 | 0.34.5  | 0.36.1  |                                         |
| claude                     | 2.1.187 | 2.1.201 | downloaded through 8118 proxy           |
| codex                      | 0.142.0 | 0.142.5 | release tag `rust-v0.142.5`             |
| stalwart                   | 0.16.10 | 0.16.11 |                                         |
| genai-toolbox              | 1.5.0   | 1.6.0   | external build artifacts as mcp-toolbox |
| npgsqlrest                 | 3.18.1  | 3.19.0  |                                         |
| postgrest                  | 14.13   | 14.14   |                                         |
| opencode                   | 1.17.9  | 1.17.13 |                                         |
| uv                         | 0.11.24 | 0.11.26 |                                         |
| grafana                    | 13.0.2  | 13.1.0  | downloaded directly                     |
| crush                      | 0.79.1  | 0.81.0  | downloaded directly                     |
| code                       | 1.125.1 | 1.127.0 | downloaded directly                     |
| code-server                | 4.125.0 | 4.127.0 | downloaded directly                     |


**2026-06-24**

| Name                    | Old            | New            | Comment                         |
|:------------------------|:---------------|:---------------|:--------------------------------|
| VictoriaMetrics         | 1.145.0        | 1.146.0        | bundled cluster / vmutils       |
| dblab                   | 0.40.2         | 0.42.0         |                                 |
| tigerbeetle             | 0.17.7         | 0.17.8         |                                 |
| grafana-victorialogs-ds | 0.28.0         | 0.29.0         |                                 |
| kafka                   | 4.3.0          | 4.3.1          | noarch package                  |
| headscale               | 0.29.0         | 0.29.1         |                                 |
| hugo                    | 0.163.2        | 0.163.3        |                                 |
| seaweedfs               | 4.34           | 4.35           |                                 |
| agentsview              | 0.33.1         | 0.34.5         |                                 |
| claude                  | 2.1.181        | 2.1.187        | downloaded through 8118 proxy   |
| codex                   | 0.140.0        | 0.142.0        | release tag `rust-v0.142.0`     |
| genai-toolbox           | 1.1.0          | 1.5.0          | external build artifacts synced |
| stalwart                | 0.16.9         | 0.16.10        |                                 |
| npgsqlrest              | 3.17.0         | 3.18.1         |                                 |
| opencode                | 1.17.8         | 1.17.9         |                                 |
| uv                      | 0.11.21        | 0.11.24        |                                 |
| nodejs                  | 24.16.0        | 24.18.0        |                                 |
| pgschema                | 1.11.0         | 1.11.1         | downloaded directly             |
| crush                   | 0.77.0         | 0.79.1         | downloaded directly             |
| minio                   | 20260417000000 | 20260618000000 | already staged                  |
| code                    | 1.125.0        | 1.125.1        | downloaded directly             |
| code-server             | 4.124.2        | 4.125.0        | downloaded directly             |
| cloudflared             | 2026.6.0       | 2026.6.1       | downloaded directly             |
| pev2                    | 1.21.0         | 1.22.0         | noarch package                  |
| pig                     | 1.4.1          | 1.4.2          | already staged                  |
| pg_exporter             | 1.2.2          | 1.3.0          | downloaded directly             |


**2026-06-18**

| Name            | Old     | New     | Comment                          |
|:----------------|:--------|:--------|:---------------------------------|
| agentsview      | 0.32.1  | 0.33.1  |                                  |
| alertmanager    | 0.32.2  | 0.33.0  |                                  |
| asciinema       | 3.2.0   | 3.2.1   |                                  |
| claude          | 2.1.172 | 2.1.181 | downloaded through 8118 proxy    |
| codex           | 0.139.0 | 0.140.0 | release tag `rust-v0.140.0`      |
| dblab           | 0.40.1  | 0.40.2  |                                  |
| duckdb          | 1.5.3   | 1.5.4   |                                  |
| headscale       | 0.28.0  | 0.29.0  |                                  |
| hugo            | 0.163.0 | 0.163.2 |                                  |
| npgsqlrest      | 3.16.3  | 3.17.0  |                                  |
| opencode        | 1.17.3  | 1.17.8  |                                  |
| pgstream        | 1.0.3   | 1.1.0   |                                  |
| rainfrog        | 0.3.18  | 0.3.19  |                                  |
| sabiql          | 1.12.3  | 1.13.0  |                                  |
| seaweedfs       | 4.32    | 4.34    |                                  |
| stalwart        | 0.16.8  | 0.16.9  |                                  |
| tigerbeetle     | 0.17.6  | 0.17.7  |                                  |
| uv              | 0.11.20 | 0.11.21 |                                  |
| victoria-logs   | 1.50.0  | 1.51.0  | bundled `vlagent` / `vlogscli`   |
| victoria-traces | 0.9.2   | 0.9.3   |                                  |
| crush           | 0.76.0  | 0.77.0  | direct-download artifact refresh |
| code            | 1.124.0 | 1.125.0 | direct-download artifact refresh |
| code-server     | 4.123.0 | 4.124.2 | direct-download artifact refresh |


**2026-06-11**

| Name                     | Old      | New      | Comment                          |
|:-------------------------|:---------|:---------|:---------------------------------|
| alertmanager             | 0.32.1   | 0.32.2   |                                  |
| redis_exporter           | 1.84.0   | 1.86.0   |                                  |
| victoria-metrics         | 1.144.0  | 1.145.0  |                                  |
| victoria-metrics-cluster | 1.144.0  | 1.145.0  | bundled with VictoriaMetrics     |
| vmutils                  | 1.144.0  | 1.145.0  | bundled with VictoriaMetrics     |
| restic                   | 0.18.1   | 0.19.0   |                                  |
| tigerbeetle              | 0.17.5   | 0.17.6   |                                  |
| hugo                     | 0.162.1  | 0.163.0  |                                  |
| seaweedfs                | 4.31     | 4.32     |                                  |
| rustfs                   | 1.0.0-b6 | 1.0.0-b8 | prerelease line                  |
| sabiql                   | 1.12.2   | 1.12.3   |                                  |
| agentsview               | 0.31.1   | 0.32.1   |                                  |
| claude                   | 2.1.161  | 2.1.172  | downloaded through 8118 proxy    |
| codex                    | 0.136.0  | 0.139.0  | release tag `rust-v0.139.0`      |
| stalwart                 | 0.16.7   | 0.16.8   |                                  |
| postgrest                | 14.12    | 14.13    |                                  |
| opencode                 | 1.15.13  | 1.17.3   |                                  |
| uv                       | 0.11.18  | 0.11.20  |                                  |
| vector                   | 0.55.0   | 0.56.0   | direct-download artifact refresh |
| pgschema                 | 1.10.0   | 1.11.0   | direct-download artifact refresh |
| crush                    | 0.75.0   | 0.76.0   | direct-download artifact refresh |
| rclone                   | 1.74.2   | 1.74.3   | direct-download artifact refresh |
| code                     | 1.123.0  | 1.124.0  | direct-download artifact refresh |
| code-server              | 4.122.1  | 4.123.0  | direct-download artifact refresh |
| cloudflared              | 2026.5.2 | 2026.6.0 | direct-download artifact refresh |



**2026-06-03**

| Name                       | Old                | New      | Comment                                    |
|:---------------------------|:-------------------|:---------|:-------------------------------------------|
| prometheus                 | 3.11.3             | 3.12.0   |                                            |
| pushgateway                | 1.11.2             | 1.11.3   |                                            |
| victoria-metrics           | 1.143.0            | 1.144.0  |                                            |
| victoria-metrics-cluster   | 1.143.0            | 1.144.0  | bundled with VictoriaMetrics               |
| vmutils                    | 1.143.0            | 1.144.0  | bundled with VictoriaMetrics               |
| victoria-traces            | 0.8.2              | 0.9.2    |                                            |
| etcd                       | 3.6.11             | 3.6.12   |                                            |
| tigerfs                    | 0.6.0              | 0.7.0    |                                            |
| dblab                      | 0.40.0             | 0.40.1   |                                            |
| tigerbeetle                | 0.17.4             | 0.17.5   |                                            |
| grafana-victorialogs-ds    | 0.27.1             | 0.28.0   |                                            |
| grafana-victoriametrics-ds | 0.24.0             | 0.25.0   |                                            |
| caddy                      | 2.11.3             | 2.11.4   |                                            |
| hugo                       | 0.161.1            | 0.162.1  |                                            |
| seaweedfs                  | 4.28               | 4.31     |                                            |
| rustfs                     | 1.0.0-b4           | 1.0.0-b6 | prerelease line                            |
| agentsview                 | 0.30.0             | 0.31.1   | upstream moved to kenn-io/agentsview       |
| claude                     | 2.1.150            | 2.1.161  | downloaded through 8118 proxy and verified |
| codex                      | 0.133.0            | 0.136.0  | release tag `rust-v0.136.0`                |
| stalwart                   | 0.16.6             | 0.16.7   |                                            |
| npgsqlrest                 | 3.16.0             | 3.16.3   |                                            |
| opencode                   | 1.15.10            | 1.15.13  |                                            |
| uv                         | 0.11.16            | 0.11.18  |                                            |
| golang                     | 1.26.3             | 1.26.4   |                                            |
| grafana                    | 13.0.1+security-01 | 13.0.2   | direct-download artifact refresh; stable   |
| pgschema                   | 1.9.0              | 1.10.0   | direct-download artifact refresh           |
| crush                      | 0.71.0             | 0.75.0   | direct-download artifact refresh           |
| code                       | 1.121.0            | 1.123.0  | direct-download artifact refresh           |
| code-server                | 4.121.0            | 4.122.1  | direct-download artifact refresh           |
| cloudflared                | 2026.5.0           | 2026.5.2 | direct-download artifact refresh           |




**2026-05-24**

| Name                    | Old      | New                | Comment                                  |
|:------------------------|:---------|:-------------------|:-----------------------------------------|
| redis_exporter          | 1.83.0   | 1.84.0             |                                          |
| duckdb                  | 1.5.2    | 1.5.3              |                                          |
| dblab                   | 0.38.0   | 0.40.0             |                                          |
| pgstream                | 1.0.2    | 1.0.3              |                                          |
| grafana-victorialogs-ds | 0.26.3   | 0.27.1             |                                          |
| kafka                   | 4.2.0    | 4.3.0              |                                          |
| caddy                   | 2.11.2   | 2.11.3             |                                          |
| seaweedfs               | 4.23     | 4.28               |                                          |
| rustfs                  | 1.0.0-b2 | 1.0.0-b4           | prerelease line                          |
| v2ray                   | 5.48.0   | 5.49.0             | README label remains `vray`              |
| agentsview              | 0.29.0   | 0.30.0             |                                          |
| claude                  | 2.1.138  | 2.1.150            | metadata updated; 8118 proxy unavailable |
| codex                   | 0.130.0  | 0.133.0            |                                          |
| stalwart                | 0.16.4   | 0.16.6             |                                          |
| maddy                   | 0.9.4    | 0.9.5              |                                          |
| npgsqlrest              | 3.15.1   | 3.16.0             |                                          |
| postgrest               | 14.11    | 14.12              |                                          |
| opencode                | 1.14.48  | 1.15.10            |                                          |
| uv                      | 0.11.13  | 0.11.16            |                                          |
| nodejs                  | 24.15.0  | 24.16.0            | kept on 24.x line                        |
| grafana                 | 13.0.1   | 13.0.1+security-01 | direct-download artifact refresh         |
| crush                   | 0.66.1   | 0.71.0             | direct-download artifact refresh         |
| rclone                  | 1.74.1   | 1.74.2             | direct-download artifact refresh         |
| code                    | 1.118.1  | 1.121.0            | direct-download artifact refresh         |
| code-server             | 4.118.0  | 4.121.0            | direct-download artifact refresh         |
| cloudflared             | 2026.3.0 | 2026.5.0           | direct-download artifact refresh         |


**2026-05-11**

| Name                     | Old      | New      | Comment                                    |
|:-------------------------|:---------|:---------|:-------------------------------------------|
| victoria-metrics         | 1.142.0  | 1.143.0  |                                            |
| victoria-metrics-cluster | 1.142.0  | 1.143.0  | bundled with VictoriaMetrics               |
| vmutils                  | 1.142.0  | 1.143.0  | bundled with VictoriaMetrics               |
| mongodb_exporter         | 0.50.0   | 0.51.0   |                                            |
| redis_exporter           | 1.82.0   | 1.83.0   |                                            |
| etcd                     | 3.6.10   | 3.6.11   |                                            |
| pgstream                 | 1.0.1    | 1.0.2    |                                            |
| seaweedfs                | 4.22     | 4.23     |                                            |
| rustfs                   | 1.0.0-b1 | 1.0.0-b2 | prerelease line                            |
| tigerbeetle              | 0.17.2   | 0.17.4   |                                            |
| sabiql                   | 1.11.1   | 1.12.2   |                                            |
| agentsview               | 0.26.0   | 0.29.0   |                                            |
| claude                   | 2.1.123  | 2.1.138  | downloaded through 8118 proxy and verified |
| codex                    | 0.125.0  | 0.130.0  |                                            |
| stalwart                 | 0.16.2   | 0.16.4   |                                            |
| maddy                    | 0.9.3    | 0.9.4    |                                            |
| npgsqlrest               | 3.12.0   | 3.15.1   |                                            |
| postgrest                | 14.10    | 14.11    |                                            |
| opencode                 | 1.14.30  | 1.14.48  |                                            |
| uv                       | 0.11.8   | 0.11.13  |                                            |
| golang                   | 1.26.2   | 1.26.3   |                                            |
| crush                    | 0.64.0   | 0.66.1   | direct-download artifact refresh           |
| rclone                   | 1.73.5   | 1.74.1   | direct-download artifact refresh           |
| code-server              | 4.117.0  | 4.118.0  | direct-download artifact refresh           |
| cloudflared              | 2026.2.0 | 2026.3.0 | direct-download artifact refresh           |


**2026-04-30**

| Name                     | Old            | New          | Comment                                    |
|:-------------------------|:---------------|:-------------|:-------------------------------------------|
| prometheus               | 3.11.2         | 3.11.3       |                                            |
| alertmanager             | 0.32.0         | 0.32.1       |                                            |
| victoria-metrics         | 1.140.0        | 1.142.0      |                                            |
| victoria-metrics-cluster | 1.140.0        | 1.142.0      | bundled with VictoriaMetrics               |
| vmutils                  | 1.140.0        | 1.142.0      | bundled with VictoriaMetrics               |
| victoria-traces          | 0.8.1          | 0.8.2        |                                            |
| tigerbeetle              | 0.17.1         | 0.17.2       |                                            |
| loki                     | 3.6.7          | 3.6.7        | obsolete; kept frozen                      |
| promtail                 | 3.6.7          | 3.6.7        | obsolete; kept frozen                      |
| logcli                   | 3.6.7          | 3.6.7        | obsolete; kept frozen with Loki            |
| hugo                     | 0.160.1        | 0.161.1      |                                            |
| seaweedfs                | 4.21           | 4.22         |                                            |
| rustfs                   | 1.0.0-alpha.94 | 1.0.0-beta.1 | prerelease line                            |
| sabiql                   | 1.11.0         | 1.11.1       |                                            |
| timescaledb-tools        | 0.18.2         | 0.19.0       | rebuilt timescaledb-tune Linux binaries    |
| agentsview               | 0.25.0         | 0.26.0       |                                            |
| claude                   | 2.1.119        | 2.1.123      | downloaded through 8118 proxy and verified |
| stalwart                 | 0.16.0         | 0.16.2       |                                            |
| opencode                 | 1.14.24        | 1.14.30      |                                            |
| uv                       | 0.11.7         | 0.11.8       |                                            |
| vip-manager              | 4.0.0          | 4.2.0        | direct-download metadata refresh           |
| crush                    | 0.62.1         | 0.64.0       | direct-download metadata refresh           |
| code                     | 1.115.0        | 1.118.1      | direct-download metadata refresh           |

**2026-04-25**

| Name                | Old     | New     | Comment                                     |
|:--------------------|:--------|:--------|:--------------------------------------------|
| grafana             | 13.0.0  | 13.0.1  | direct-download metadata refresh            |
| vector              | 0.54.0  | 0.55.0  | direct-download metadata refresh            |
| keepalived_exporter | 1.7.0   | 1.7.1   |                                             |
| seaweedfs           | 4.20    | 4.21    |                                             |
| tigerbeetle         | 0.17.0  | 0.17.1  |                                             |
| agentsview          | 0.22.2  | 0.25.0  |                                             |
| claude              | 2.1.114 | 2.1.119 | downloaded through 8118 proxy and verified  |
| codex               | 0.121.0 | 0.125.0 |                                             |
| stalwart            | 0.15.5  | 0.16.0  |                                             |
| opencode            | 1.4.11  | 1.14.24 |                                             |
| crush               | 0.57.0  | 0.62.1  | direct-download metadata refresh            |
| rclone              | 1.73.4  | 1.73.5  | direct-download metadata refresh            |
| code-server         | 4.115.0 | 4.117.0 | direct-download metadata refresh            |
| pig                 | 1.4.0   | 1.4.1   | metadata only; artifacts handled separately |

**2026-04-18**

| Name                       | Old             | New            | Comment                                                 |
|:---------------------------|:----------------|:---------------|:--------------------------------------------------------|
| victoria-logs              | 1.49.0          | 1.50.0         |                                                         |
| vlagent                    | 1.49.0          | 1.50.0         | bundled with VictoriaLogs                               |
| vlogscli                   | 1.49.0          | 1.50.0         | bundled with VictoriaLogs                               |
| victoria-traces            | 0.8.0           | 0.8.1          |                                                         |
| dblab                      | 0.37.1          | 0.38.0         |                                                         |
| grafana-victoriametrics-ds | 0.23.4          | 0.24.0         |                                                         |
| grafana-plugins            | 12.3.0          | 13.0.0         | noarch plugin bundle, manually consolidated             |
| garage                     | 2.2.0           | 2.3.0          |                                                         |
| rustfs                     | 1.0.0-alpha.93  | 1.0.0-alpha.94 |                                                         |
| claude                     | 2.1.107         | 2.1.114        | rebuilt via versioned release template to latest stable |
| codex                      | 0.121.0-alpha.7 | 0.121.0        | stable release, rebuilt                                 |
| genai-toolbox              | 1.0.0           | 1.1.0          | external build artifacts synced from genai-toolbox      |
| postgrest                  | 14.9            | 14.10          |                                                         |
| opencode                   | 1.4.3           | 1.4.11         | switched to versioned tarball cache and rebuilt         |
| uv                         | 0.11.6          | 0.11.7         |                                                         |
| nodejs                     | 24.14.1         | 24.15.0        | kept on 24.x line                                       |
| minio                      | 20260325000000  | 20260417000000 | direct-download metadata; pgsty fork build refresh      |
| mcli                       | 20260321000000  | 20260417000000 | direct-download metadata; pgsty fork build refresh      |
| sabiql                     | 1.10.0          | 1.11.0         |                                                         |
| etcd                       | 3.6.8           | 3.6.10         | unified package version                                 |

**2026-04-14**

| Name                       | Old            | New             | Comment                                      |
|:---------------------------|:---------------|:----------------|:---------------------------------------------|
| prometheus                 | 3.10.0         | 3.11.2          |                                              |
| alertmanager               | 0.31.1         | 0.32.0          |                                              |
| node_exporter              | 1.10.2         | 1.11.1          |                                              |
| mongodb_exporter           | 0.49.0         | 0.50.0          |                                              |
| victoria-metrics           | 1.138.0        | 1.140.0         |                                              |
| victoria-metrics-cluster   | 1.138.0        | 1.140.0         | bundled with VictoriaMetrics                 |
| vmutils                    | 1.138.0        | 1.140.0         | bundled with VictoriaMetrics                 |
| victoria-logs              | 1.48.0         | 1.49.0          |                                              |
| vlagent                    | 1.48.0         | 1.49.0          | bundled with VictoriaLogs                    |
| vlogscli                   | 1.48.0         | 1.49.0          | bundled with VictoriaLogs                    |
| grafana                    | 12.4.1         | 13.0.0          | major release                                |
| duckdb                     | 1.5.0          | 1.5.2           |                                              |
| dblab                      | 0.34.3         | 0.37.1          |                                              |
| grafana-victoriametrics-ds | 0.23.1         | 0.23.4          |                                              |
| grafana-infinity-ds        | 3.7.4          | 3.8.0           |                                              |
| seaweedfs                  | 4.17           | 4.20            |                                              |
| rustfs                     | 1.0.0-alpha.89 | 1.0.0-alpha.93  | switched to versioned release assets         |
| v2ray                      | 5.47.0         | 5.48.0          |                                              |
| xray                       | 26.2.6         | 26.3.27         |                                              |
| agentsview                 | 0.15.0         | 0.22.2          |                                              |
| claude                     | 2.1.81         | 2.1.107         | rebuilt; Makefile now pulls versioned bucket |
| codex                      | 0.116.0        | 0.121.0-alpha.7 | prerelease chain; rebuilt                    |
| maddy                      | 0.8.2          | 0.9.3           |                                              |
| genai-toolbox              | 0.27.0         | 1.0.0           | metadata only; renamed to mcp-toolbox        |
| npgsqlrest                 | 3.11.1         | 3.12.0          |                                              |
| postgrest                  | 14.7           | 14.9            |                                              |
| rainfrog                   | 0.3.17         | 0.3.18          |                                              |
| sqlcmd                     | 1.9.0          | 1.10.0          |                                              |
| opencode                   | 1.2.27         | 1.4.3           | rebuilt                                      |
| uv                         | 0.10.12        | 0.11.6          |                                              |
| golang                     | 1.26.1         | 1.26.2          |                                              |
| nodejs                     | 24.14.0        | 24.14.1         | kept on 24.x line                            |
| pgschema                   | 1.7.4          | 1.9.0           |                                              |
| crush                      | 0.51.2         | 0.57.0          |                                              |
| rclone                     | 1.73.2         | 1.73.4          |                                              |
| code                       | 1.112.0        | 1.115.0         |                                              |
| code-server                | 4.112.0        | 4.115.0         |                                              |
| tigerbeetle                | 0.16.77        | 0.17.0          |                                              |
| tigerfs                    | 0.5.0          | 0.6.0           |                                              |
| sabiql                     | 1.8.2          | 1.10.0          |                                              |
| hugo                       | 0.158.0        | 0.160.1         |                                              |
| etcd                       | 3.6.9          | 3.6.8           | frozen at 3.6.8; README corrected            |
| loki                       | 3.6.7          | 3.6.7           | kept enabled                                 |
| promtail                   | 3.6.7          | 3.6.7           | kept enabled                                 |
| pg_exporter                | 1.2.1          | 1.2.2           | direct-download metadata                     |
| pig                        | 1.3.2          | 1.3.4           | direct-download metadata                     |
| pgflo                      | 0.0.15         | -               | removed                                      |


**2026-03-21**

- grafana 12.4.0 -> 12.4.1
- pgbackrest_exporter 0.22.0 -> 0.23.0
- redis_exporter 1.81.0 -> 1.82.0
- victoria-logs 1.47.0 -> 1.48.0
- vlagent 1.47.0 -> 1.48.0
- vlogscli 1.47.0 -> 1.48.0
- victoria-traces 0.7.1 -> 0.8.0
- duckdb 1.4.4 -> 1.5.0
- pg_timetable 6.2.0 -> 6.3.0
- tigerbeetle 0.16.75 -> 0.16.77
- grafana-victorialogs-ds 0.26.2 -> 0.26.3
- grafana-infinity-ds 3.7.3 -> 3.7.4
- caddy 2.11.1 -> 2.11.2
- npgsqlrest 3.10.0 -> 3.11.1
- postgrest 14.5 -> 14.7
- opencode 1.2.17 -> 1.2.27
- pev2 1.20.2 -> 1.21.0
- golang 1.26.0 -> 1.26.1
- vector 0.53.0 -> 0.54.0
- rclone 1.73.1 -> 1.73.2
- code-server 4.109.5 -> 4.112.0
- code 1.109.4 -> 1.112.0
- seaweedfs 4.15 -> 4.17
- uv 0.10.8 -> 0.10.12
- codex 0.110.0 -> 0.116.0
- vray 5.44.1 -> 5.47.0
- sabiql 1.6.2 -> 1.8.2
- pgschema 1.4.2 -> 1.7.4
- pgstream new 1.0.1
- sql-studio new 0.1.51
- rainfrog new 0.3.17
- agentsview 0.10.0 -> 0.15.0
- crush new 0.51.2
- tigerfs new 0.5.0
- victoria-metrics 1.137.0 -> 1.138.0
- victoria-metrics-cluster 1.137.0 -> 1.138.0
- vmutils 1.137.0 -> 1.138.0
- hugo 0.157.0 -> 0.158.0
- rustfs 1.0.0-alpha.85 -> 1.0.0-alpha.89
- mysqld_exporter 0.18.0 -> 0.19.0
- pg_exporter 1.2.0 -> 1.2.1
- pig 1.3.1 -> 1.3.2
- minio 20260214 -> 20260314
- mcli 20260213 -> 20260313
- claude 2.1.68 -> 2.1.81
- genai-toolbox 0.27.0 -> 0.30.0

**2026-03-05**

- asciinema 3.1.0 -> 3.2.0
- grafana-infinity-ds 3.7.2 -> 3.7.3
- victoria-metrics 1.136.0 -> 1.137.0
- victoria-metrics-cluster 1.136.0 -> 1.137.0
- vmutils 1.136.0 -> 1.137.0
- hugo 0.155.3 -> 0.157.0
- opencode 1.2.15 -> 1.2.17
- rustfs 1.0.0-alpha.83 -> 1.0.0-alpha.85
- seaweedfs 4.13 -> 4.15
- tigerbeetle 0.16.74 -> 0.16.75
- uv 0.10.4 -> 0.10.8
- codex 0.105.0 -> 0.110.0
- claude 2.1.59 -> 2.1.68
- xray new 26.2.6
- gost new 2.12.0
- sabiql new 1.6.2
- agentsview new 0.10.0


**2026-02-26**

- grafana 12.3.3 -> 12.4.0
- prometheus 3.9.1 -> 3.10.0
- mongodb_exporter 0.47.2 -> 0.49.0
- victoria-logs 1.45.0 -> 1.47.0
- vlagent 1.45.0 -> 1.47.0
- vlogscli 1.45.0 -> 1.47.0
- tigerbeetle 0.16.73 -> 0.16.74
- loki 3.6.6 -> 3.6.7
- promtail 3.6.6 -> 3.6.7
- logcli 3.6.6 -> 3.6.7
- grafana-victorialogs-ds 0.25.0 -> 0.26.2
- grafana-victoriametrics-ds 0.22.0 -> 0.23.1
- grafana-infinity-ds 3.7.1 -> 3.7.2
- caddy 2.10.2 -> 2.11.1
- npgsqlrest 3.8.0 -> 3.10.0
- opencode 1.2.10 -> 1.2.15
- nodejs 24.13.1 -> 24.14.0
- pev2 1.20.1 -> 1.20.2
- claude 2.1.45 -> 2.1.59
- codex 0.104.0 -> 0.105.0
- pig 1.2.0 -> 1.3.0


**2026-02-22**

- victoria-metrics 1.135.0 -> 1.136.0
- victoria-metrics-cluster 1.135.0 -> 1.136.0
- vmutils 1.135.0 -> 1.136.0
- loki 3.6.5 -> 3.6.6
- promtail 3.6.5 -> 3.6.6
- logcli 3.6.5 -> 3.6.6
- opencode 1.2.6 -> 1.2.10
- stalwart new 0.15.5
- maddy new 0.8.2

**2026-02-18**

- grafana 12.3.2 -> 12.3.3
- grafana-victorialogs-ds 0.24.1 -> 0.25.0
- grafana-victoriametrics-ds 0.21.0 -> 0.22.0
- grafana-infinity-ds 3.7.0 -> 3.7.1
- redis_exporter 1.80.2 -> 1.81.0
- etcd 3.6.7 -> 3.6.8
- dblab 0.34.2 -> 0.34.3
- tigerbeetle 0.16.72 -> 0.16.73
- seaweedfs 4.09 -> 4.13
- rustfs 1.0.0-alpha.82 -> 1.0.0-alpha.83
- uv 0.10.0 -> 0.10.4
- kafka 4.1.1 -> 4.2.0
- npgsqlrest 3.7.0 -> 3.8.0
- postgrest 14.4 -> 14.5
- opencode 1.1.59 -> 1.2.6
- genai-toolbox 0.25.0 -> 0.27.0
- claude 2.1.37 -> 2.1.45
- rclone 1.73.0 -> 1.73.1
- code-server 4.108.2 -> 4.109.2
- code 1.109.2 -> 1.109.4
- pig 1.1.1 -> 1.1.2


**2026-02-08**

- alertmanager 0.30.1 -> 0.31.0
- victoria-metrics 1.134.0 -> 1.135.0
- victoria-metrics-cluster 1.134.0 -> 1.135.0
- vmutils 1.134.0 -> 1.135.0
- victoria-logs 1.43.1 -> 1.45.0
- vlagent 1.43.1 -> 1.45.0
- vlogscli 1.43.1 -> 1.45.0
- grafana-victorialogs-ds 0.23.5 -> 0.24.1
- grafana-victoriametrics-ds 0.20.1 -> 0.21.0
- tigerbeetle 0.16.68 -> 0.16.70
- loki 3.1.1 -> 3.6.5
- promtail 3.0.0 -> 3.6.5
- logcli 3.1.1 -> 3.6.5
- redis_exporter 1.80.1 -> 1.80.2
- timescaledb-tools 0.18.1 -> 0.18.2
- seaweedfs 4.06 -> 4.09
- rustfs 1.0.0-alpha.80 -> 1.0.0-alpha.82
- uv 0.9.26 -> 0.10.0
- garage 2.1.0 -> 2.2.0
- headscale 0.27.1 -> 0.28.0
- hugo 0.154.5 -> 0.155.3
- pev2 1.20.0 -> 1.20.1
- postgrest 14.3 -> 14.4
- npgsqlrest 3.4.7 -> 3.7.0
- opencode 1.1.34 -> 1.1.53
- golang 1.25.6 -> 1.25.7
- nodejs 24.12.0 -> 24.13.0
- claude 2.1.19 -> 2.1.37
- vector 0.52.0 -> 0.53.0
- code 1.108.0 -> 1.109.0
- code-server 4.108.0 -> 4.108.2
- rclone 1.72.1 -> 1.73.0
- pg_exporter 1.1.2 -> 1.2.0
- grafana 12.3.1 -> 12.3.2
- pig 1.0.0 -> 1.1.0
- cloudflared 2026.1.1 -> 2026.2.0


**2026-01-25**

- alertmanager 0.30.0 -> 0.30.1
- victoria-metrics 1.133.0 -> 1.134.0
- victoria-traces 0.5.1 -> 0.7.1
- grafana-victorialogs-ds 0.23.3 -> 0.23.5
- grafana-victoriametrics-ds 0.20.0 -> 0.20.1
- npgsqlrest 3.4.3 -> 3.4.7
- caddy new 2.10.2
- claude 2.1.9 -> 2.1.19
- opencode 1.1.23 -> 1.1.34
- hugo new 0.154.5
- cloudflared new 2026.1.1
- headscale new 0.27.1


**2026-01-16**

- prometheus 3.8.1 -> 3.9.1
- victoria-metrics 1.132.0 -> 1.133.0
- tigerbeetle 0.16.65 -> 0.16.68
- kafka 4.0.0 -> 4.1.1
- grafana-victoriametrics-ds 0.19.7 -> 0.20.0
- grafana-victorialogs-ds 0.23.2 -> 0.23.3
- grafana-infinity-ds 3.6.0 -> 3.7.0
- uv 0.9.18 -> 0.9.26
- seaweedfs 4.01 -> 4.06
- rustfs alpha.71 -> alpha.80
- v2ray 5.28.0 -> 5.44.1
- sqlcmd 1.8.0 -> 1.9.0
- opencode 1.0.223 -> 1.1.23
- claude 2.1.1 -> 2.1.9
- golang 1.25.5 -> 1.25.6
- asciinema 3.0.1 -> 3.1.0
- code 1.107.0 -> 1.108.0
- code-server 4.107.0 -> 4.108.0
- npgsqlrest 3.3.0 -> 3.4.3
- genai-toolbox 0.24.0 -> 0.25.0
- pg_exporter 1.1.1 -> 1.1.2
- pig 0.9.0 0.9.1

```bash
make prometheus
make victoria-metrics
make tigerbeetle
make kafka
make grafana-victoriametrics-ds
make grafana-victorialogs-ds
make uv
make seaweedfs
make rustfs
make v2ray
make sqlcmd
make opencode
make claude
make golang
make asciinema
make npgsqlrest
make genai-toolbox
```


**2026-01-08**

- code 1.107.0
- code-server 1.107.0
- golang 1.25.5
- nodejs 24.12.0
- opencode 1.0.223

**2025-12-27**

- pig                 : 0.8.1 
- uv                  : 0.9.18
- ccm                 : 2.0.76
- IvorySQL            : 5.1   
- asciinema           : 3.0.1 
- grafana             : 12.3.1
- vector              : 0.52.0
- etcd                : 3.6.7
- prometheus          : 3.8.1
- alertmanager        : 0.30.0
- victorialogs        : 1.43.1
- pgbackrest_exporter : 0.22.0


**2025-12-16**

- victoria-metrics 1.131.0 -> 1.132.0
- victora-logs 1.40.0 -> 1.41.0
- blackbox_exporter 0.27.0 -> 0.28.0
- duckdb 1.4.2 -> 1.4.3
- rclone 1.72.0 -> 1.72.1
- pev2 1.17.0 -> 1.19.0

**2025-12-06**

- minio 20250422221226
- rustfs 1.0.0-a71
- seaweedfs 4.1.0
- garage 2.1.0
- juicefs 1.3.1
- rclone 1.72.0
- vector 1.5.1
- prometheus 3.8.0
- victoriametrics 1.131.0
- victorialogs 1.40.0
- redis_exporter 1.80.1
- mongodb_exporter 0.47.2
- grafana-victorialogs-ds 0.22.4

**2025-11-23**

- pg_timetable 6.2.0
- genai-toolbox 0.16.0 -> 0.21.0
- etcd 3.6.5 -> 3.6.6
- duckdb 1.4.1 -> 1.4.2
- sealos 5.0.1 -> 5.1.1
- vector 1.51.0 -> 1.51.1
- timescaledb-tools 0.18.1
- timescaledb-event-streamer 0.20.0
- tigerbeetle 0.16.65
- victoria-metrics 1.129.1 -> 1.130.0
- victorialogs 1.37.2 -> 1.38.0
- grafana-victorialogs-ds 0.21.4 -> 0.22.1
- grafana-victoriametrics-ds 0.19.6 -> 0.19.7
- grafana-plugins 12.0.0 -> 12.3.1
- pgflo 0.0.15


**2025-11-11**

- prometheus 3.6.0 -> 3.7.3
- pushgateway 1.11.1 -> 1.11.2
- alertmanager 0.28.1 -> 0.29.0
- nginx_exporter 1.5.0 -> 1.5.1
- node_exporter 1.9.1 -> 1.10.2
- pgbackrest_exporter 0.20.0 -> 0.21.0
- redis_exporter 1.77.0 -> 1.80.0
- duckdb 1.4.0 -> 1.4.1
- dblab 0.33.0 -> 0.34.2
- pg_timetable 5.13.0 -> 6.1.0
- vector 0.50.0 -> 0.51.0
- rclone 1.71.1 -> 1.71.2
- victoria-metrics 1.126.0 -> 1.129.1
- victoria-logs 1.35.0 -> 1.37.2
- grafana-victorialogs-ds 0.21.0 -> 0.21.4
- grafana-victoriametrics-ds 0.19.4 -> 0.19.6
- grafana-infinity-ds 3.5.0 -> 3.6.0
- pev2 1.16.0 -> 1.17.0
- FerretDB 2.6.0 -> 2.7.0


**2025-10-02**

- prometheus 3.5.0 -> 3.6.0
- nginx_exporter 1.4.2 -> 1.5.0
- mysqld_exporter 0.17.2 -> 0.18.0
- redis_exporter 1.75.0 -> 1.77.0
- mongodb_exporter 0.47.0 -> 0.47.1
- victoria-metrics 1.121.0 -> 1.126.0
- vicotira-logs 1.25.1 -> 1.35.0
- duckdb 1.3.2 -> 1.4.0
- etcd 3.6.4 -> 3.6.5
- restic 0.18.0 -> 0.18.1
- tigerbeetle 0.16.54 -> 0.16.60
- grafana-victorialogs-ds 0.19.3 -> 0.21.0
- grafana-victoriametrics-ds 0.18.3 -> 0.19.4
- grafana-infinity-ds 3.3.0 -> 3.5.0
- genai-toolbox 0.9.0 -> 0.16.0
- vector 0.49.0 -> 0.50.0
- rclone 1.70.3 -> 1.71.1
- minio 20250907161309
- mcli 20250813083541

**2025-08-15**

- Grafana 12.1.0
- pg_exporter 1.0.2
- pig 0.6.1
- vector 0.49.0
- redis_exporter 1.75.0
- mongo_exporter 0.47.0
- victoriametrics 1.123.0
- victorialogs: 1.28.0
- grafana-victoriametrics-ds 0.18.3
- grafana-victorialogs-ds 0.19.3
- grafana-infinity-ds 3.4.1
- etcd 3.6.4
- ferretdb 2.5.0
- tigerbeetle 0.16.54
- genai-toolbox 0.12.0


**2025-07-24**

- FerretDB 2.4.0
- etcd 3.6.3
- minio 20250723155402
- mcli 20250721052808

**2025-07-16**

- genai-toolbox 0.8.0 -> 0.9.0 (new)
- victoriametrics 1.120.0 -> 1.121.0 (refactor)
- victorialogs 1.24.0 -> 1.25.0 (refactor)
- prometheus 3.4.2 -> 3.5.0
- duckdb 1.3.1 -> 1.3.2
- etcd 3.6.1 -> 3.6.2
- tigerbeetle 0.16.48 -> 0.16.50
- grafana-victoriametrics-ds 0.16.0 -> 0.17.0
- rclone 1.69.3 -> 1.70.3
- pig 0.5.0 -> 0.6.0
- pev2 1.15.0 -> 1.16.0

**2025-07-04**

- [x] genai-toolbox 0.8.0
- [x] juicefs 1.2.3 -> 1.3.0
- [x] prometheus 3.4.1 -> 3.4.2
- [x] grafana 12.0.1 -> 12.0.2
- [x] vector 0.47.0 -> 0.48.0
- [x] rclone 1.69.0 -> 1.70.2
- [x] vip-manager 3.0.0 -> 4.0.0
- [x] blackbox_exporter 0.26.0 -> 0.27.0
- [x] redis_exporter 1.72.1 -> 1.74.0
- [x] duckdb 1.3.0 -> 1.3.1
- [x] etcd 3.6.0 -> 3.6.1
- [x] ferretdb 2.2.0 -> 2.3.1
- [x] dblab 0.32.0 -> 0.33.0
- [x] tigerbettle 0.16.41 -> 0.16.48
- [x] grafana-victorialogs-ds 0.16.3 -> 0.18.1
- [x] grafana-victoriametrics-ds 0.15.1 -> 0.16.0
- [x] grafana-inifinity-ds 3.2.1 -> 3.3.0
- [x] victorialogs 1.22.2 -> 1.24.0
- [x] victoriametrics 1.117.1 -> 1.120.0

**2025-06-01**

- grafana 12.0.1
- prometheus 3.4.1
- keepalived_exporter 1.7.0
- redis_exporter 1.73.0
- victoriametrics 1.118.0
- victorialogs 1.23.1
- tigerbeetle 0.16.42
- grafana-victorialogs-ds 0.17.0
- grafana-infinity-ds 3.2.2


**2025-05-22**

- dblab 0.32.0
- prometheus 3.4.0
- duckdb 1.3.0
- etcd 3.6.0
- pg_exporter 1.0.0
- ferretdb 2.2.0
- rclone 1.69.3
- minio 20250422221226
- mcli 20250416181326
- nginx_exporter 1.4.2
- keepalived_exporter 1.6.2
- pgbackrest_exporter 0.20.0
- redis_exporter 1.27.1
- victoriametrics 1.117.1
- victorialogs 1.22.2
- pg_timetable 5.13.0
- tigerbeetle 0.16.41
- pev2 1.15.0
- grafana 12.0.0
- grafana-victorialogs-ds 0.16.3
- grafana-victoriametrics-ds 0.15.1
- grafana-infinity-ds 3.2.1
- grafana_plugins 12.0.0

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
