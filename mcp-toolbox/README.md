# MCP Toolbox for Databases

This recipe packages MCP Toolbox v1.16.0 as `mcp-toolbox`, with `toolbox` as a
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

The 2026-11-06 build uses the upstream v1.16.0 commit recorded in BUILDINFO.
Go dependencies are verified with `go mod verify`; source and dependency
downloads use the host Xray proxy on port 8888. The package step uses the
repository's pinned nFPM 2.43.1.

The earlier 20261024 batch packaged v1.15.0 with nFPM 2.48.0 and passed fresh
installation, upgrade from 1.14.0, and unprivileged MCP/SQLite checks on
Debian 12 and EL8 for both architectures.

Upstream: https://github.com/googleapis/mcp-toolbox/releases/tag/v1.16.0
