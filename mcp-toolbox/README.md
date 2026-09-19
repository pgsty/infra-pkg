# MCP Toolbox for Databases

This recipe packages MCP Toolbox v1.12.0 as `mcp-toolbox`, with `toolbox` as a
command alias. Both Linux architectures are built from the upstream source
archive with Go 1.27.1, CGO enabled, and Zig 0.15.2 targeting GNU/Linux glibc
2.28. The Oracle driver requires CGO; disabling CGO is not supported.

The one-shot binaries are consumed from versioned files in the shared
`tarball/` cache and verified against the checksums in the Makefile. Source
and build provenance are recorded in BUILDINFO. Building a package does not
download dependencies or compile the source again.

```bash
make mcp-toolbox
```

Upstream: https://github.com/googleapis/mcp-toolbox/releases/tag/v1.12.0
