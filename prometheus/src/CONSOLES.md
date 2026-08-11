# Prometheus console examples

Prometheus 3.0 removed the bundled example console files while retaining the
console template feature. This package vendors the last upstream example set
from Prometheus `v2.55.1` so the configured `--web.console.libraries` and
`--web.console.templates` paths remain useful.

- Upstream tag: `v2.55.1`
- Upstream commit: `6d7569113f1ca814f1e149f74176656540043b8d`
- Source directories: `console_libraries/` and `consoles/`
- License: Apache-2.0, matching Prometheus

The files are included verbatim. During intake, each file's Git blob hash was
checked against the GitHub tree for the pinned tag.

| Git blob | Path |
|:---------|:-----|
| `199ebf9f480e9e56218febbb206566b8c409855c` | `console_libraries/menu.lib` |
| `d7d436f9474069be1878d289b5ab3c2b7b0c6479` | `console_libraries/prom.lib` |
| `c725d30dea36352fbfb9b8df7cc543dd2125eca0` | `consoles/index.html.example` |
| `284ad738f2b84f14b7870ce355a3630af466ef1f` | `consoles/node-cpu.html` |
| `ffff41b79786be5dd6847566b4272e598c6aa6a9` | `consoles/node-disk.html` |
| `4ae8984b99ada2210759d02eae5729e2cd98f7ff` | `consoles/node-overview.html` |
| `c1dfc1a8913e88b5dc84e00b928b0ebf1f51de59` | `consoles/node.html` |
| `08e027de0669d2a66dee4b96002acec7b1b2d165` | `consoles/prometheus-overview.html` |
| `e0d026376d1d8e148474a34baa84552f5ad06ec3` | `consoles/prometheus.html` |
