# MCP Toolbox for Databases

This recipe packages MCP Toolbox v1.15.0 as `mcp-toolbox`, with `toolbox` as a
command alias. Both Linux architectures are built from the upstream source
commit with Go 1.27.3, CGO enabled, and Zig 0.15.2 targeting GNU/Linux glibc
2.28. The Oracle driver requires CGO; disabling CGO is not supported.

The one-shot binaries are consumed from versioned files in the shared
`tarball/` cache and verified against the checksums in the Makefile. Source
and build provenance are recorded in BUILDINFO. Building a package does not
download dependencies or compile the source again.

```bash
make mcp-toolbox
```

The 20261024 batch imports the four packages built in the MCP Toolbox source
checkout with nFPM 2.48.0. Those packages passed fresh installation, upgrade
from 1.14.0, and unprivileged MCP/SQLite checks on Debian 12 and EL8 for both
architectures. This recipe uses the same verified binaries with the repository's
pinned nFPM version for subsequent local rebuilds.

Upstream: https://github.com/googleapis/mcp-toolbox/releases/tag/v1.15.0
