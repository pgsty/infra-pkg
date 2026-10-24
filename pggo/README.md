# pggo INFRA package

This package installs the unmodified `pgrundev/pggo` v0.1.1 release CLI to
`/usr/bin/pggo`, with the upstream MIT license and README. It does not install
the Go development library. The Linux amd64 and arm64 archives are pinned by
SHA256 in `Makefile`; `LICENSE` is copied from the same release archive and is
checked against it during extraction.

Build both RPM and DEB packages for both architectures from the repository root:

```sh
make pggo
```

The prebuilt CLI does not require Go, libpq or a local PostgreSQL server. Supply
the database connection at runtime using `DATABASE_URL` or PostgreSQL `PG*`
environment variables. Verified TLS connections need the appropriate CA roots.
Use `pggo help` and `pggo version` without a database connection. `query` runs a
read-only transaction; `exec` is the explicit command for writes.

Upstream release: https://github.com/pgrundev/pggo/releases/tag/v0.1.1
