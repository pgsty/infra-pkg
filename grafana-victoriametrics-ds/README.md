# VictoriaMetrics datasource: 0.26.1 to 1.0.1

The 1.0.0 release preserves the plugin identity, backend name, installation
directory, and Grafana requirements used by 0.26.1. The main functional changes
fix POST requests and WITH templates. The local upgrade test preserved the
existing datasource ID, UID, URL, and settings on Grafana 13.3.0.

The current package is 1.0.1. It retains that compatibility and adds fixes for
query-editor browser storage, malformed `vmui` requests, and sensitive URLs in
query errors. It also updates `golang.org/x/net` to v0.62.0.

| Property         | Value                                                          |
| :--------------- | :------------------------------------------------------------- |
| Plugin ID        | `victoriametrics-metrics-datasource`                           |
| Backend prefix   | `victoriametrics_metrics_backend_plugin`                       |
| Install location | `/var/lib/grafana/plugins/victoriametrics-metrics-datasource/` |
| License          | AGPL-3.0-only; unchanged from 0.26.1                           |
| Package outputs  | DEB and RPM for amd64/x86_64 and arm64/aarch64                 |

The unchanged upstream Grafana dependency is:

```text
>=11.6.11 <12 || >=12.0.10 <12.1 || >=12.1.7 <12.2 || >=12.2.5
```

`nfpm.yaml` expresses these constraints for both DEB and RPM. `prepare.py` stops
the build if upstream changes the requirement, identity, version, backend name,
or target ELF architecture. It validates the input before removing other
platforms' backend executables. Run `make test` in this directory to check the
validation and pruning behavior.

## Behavior changes

- With the datasource HTTP method set to POST, per-query parameters now use an
  `application/x-www-form-urlencoded` body. Health checks and metadata requests
  also receive POST handling fixes. Parameters in the configured datasource URL
  and custom query parameters remain in the URL. GET queries retain URL parameters.
- This avoids proxy URL-length limits for long POST queries. VictoriaMetrics'
  own `-search.maxQueryLen` limit remains 16 KiB by default; larger expressions
  still require changing that server setting.
- WITH templates remain intact when ad hoc filters or Explore's filter actions
  add labels. Saving templates preserves dashboard folders and handles Grafana
  13's HTTP 409 conflict response. Explore retains templates across reloads,
  shared links, and Add to dashboard; Export data resolves template queries.

## Loading the packaged plugin

These packages retain only the matching Linux backend and remove the upstream
`MANIFEST.txt`, because the signed upstream file set includes other platforms.
The resulting plugin is unsigned, as it was in the previous package. Keep its
ID in the existing Grafana unsigned-plugin allowlist:

```ini
[plugins]
allow_loading_unsigned_plugins = victoriametrics-metrics-datasource
```

If other plugin IDs are already allowed, retain them in the comma-separated
list. The equivalent environment variable is
`GF_PLUGINS_ALLOW_LOADING_UNSIGNED_PLUGINS`. Restart Grafana after upgrading
the package so it loads the new backend. The package does not restart Grafana
automatically.

## Validation on 2026-11-03

Both Linux architectures passed the same isolated test using Grafana 13.3.0
and VictoriaMetrics 1.155.0. The old plugin came from the verified 0.26.1
release archive; the new plugin came from the newly built 1.0.0 DEB payload.
Grafana restarted against the same SQLite database for the upgrade.

| Check                                | 0.26.1                            | 1.0.0                             |
| :----------------------------------- | :-------------------------------- | :-------------------------------- |
| Plugin loading and health            | Pass                              | Pass                              |
| GET/POST instant and range queries   | Pass                              | Pass                              |
| GET series lookup                    | Pass                              | Pass                              |
| POST series lookup with form body    | Body lost; lookup fails           | Body preserved; lookup succeeds   |
| Long POST through 4,096-byte URL cap | 5,104-byte URL; proxy returns 431 | 39-byte URL; 5,064-byte body; 200 |
| Configured URL/custom parameters     | Preserved                         | Preserved                         |
| Query above the VM 16 KiB limit      | Not part of the old-version test  | Correctly rejected with HTTP 400  |
| Existing datasource identity         | Baseline                          | ID, UID and settings preserved    |

These are backend/API tests. The WITH-template editor, dashboard-folder UI,
Explore sharing, and conflict dialogs were reviewed against upstream changes
but were not exercised in an interactive browser. This is not an end-to-end
installation test across every supported Linux distribution.

## Validation on 2026-11-04

Both Linux architectures passed an additional 1.0.0-to-1.0.1 upgrade test with
the same Grafana and VictoriaMetrics versions. Both plugin versions were loaded
from the actual DEB packages, and Grafana reused its SQLite database on upgrade.

| Check                                 | Result                                         |
| :------------------------------------ | :--------------------------------------------- |
| Plugin health, GET/POST and series    | Pass on both versions and architectures        |
| Long POST through 4,096-byte URL cap  | 39-byte URL; 5,064-byte body; HTTP 200         |
| Existing datasource identity          | ID, UID, URL and settings preserved            |
| Empty, invalid and trailing vmui JSON | HTTP 400; backend remains healthy              |
| Valid vmui request                    | HTTP 200 with a vmui URL                       |
| Failed upstream query                 | Error includes status 502, without request URL |
| Query error debug log                 | Parameter values replaced with REDACTED        |

The browser-storage isolation and WITH-template interactions were reviewed in
upstream code but have not been exercised in a browser. The unsigned-plugin
allowlist and restart requirement above still apply to 1.0.1.

Sources:

- [1.0.1 release notes](https://github.com/VictoriaMetrics/victoriametrics-datasource/releases/tag/v1.0.1)
- [Source changes from 1.0.0](https://github.com/VictoriaMetrics/victoriametrics-datasource/compare/v1.0.0...v1.0.1)
- [1.0.0 release notes](https://github.com/VictoriaMetrics/victoriametrics-datasource/releases/tag/v1.0.0)
- [Source changes from 0.26.1](https://github.com/VictoriaMetrics/victoriametrics-datasource/compare/v0.26.1...v1.0.0)
- [1.0.0 plugin metadata](https://github.com/VictoriaMetrics/victoriametrics-datasource/blob/v1.0.0/src/plugin.json)
