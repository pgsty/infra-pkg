# pgsync INFRA package

This package contains `pgrundev/pgsync` v0.1.1, a Rust PostgreSQL snapshot and CDC
CLI. Upstream marks this release as a **controlled technical beta**, intended
for synthetic or explicitly approved non-sensitive data. Package version
`0.1.1` preserves the upstream tag; GitHub's prerelease flag is not a separate
version suffix.

The unmodified musl release binary is installed as `/usr/bin/pgsync`. The
upstream README, example configuration and full Apache-2.0 license are installed
under `/usr/share/doc/pgsync/`. Archive SHA256 values are pinned in `Makefile`;
`LICENSE` is copied from the same release archive and checked during extraction.

Build both RPM and DEB packages for both architectures from the repository root:

```sh
make pgsync
```

Runtime prerequisites are chosen for the source and target databases:

- PostgreSQL 16, 17 or 18 is the upstream target. The source needs
  `wal_level=logical`, replication privileges, available replication slots and
  WAL senders, and a publication matching the configured tables. The target
  requires the permissions described in the upstream README.
- Default schema bootstrap invokes `pg_dump`, at least as new as the source
  PostgreSQL major. Put the selected client on `PATH`, set `schema.pg_dump_path`,
  or prepare the target schema and choose `schema.mode: existing`. No PostgreSQL
  server or version-specific client package is installed as a hard dependency.
- Verified TLS connections need the appropriate system CA roots. Supply
  connection URLs through the environment variables referenced by the example
  configuration.

Run `pgsync --help` or `pgsync --version` without connecting to a database. Copy
the documented example to a user-owned location and explicitly run `check`
before opting into `bootstrap` and replication. Installation creates no service
or database objects and configures no credentials.

This release does not replicate DDL or sequence changes. A stopped consumer can
leave a replication slot retaining WAL; monitor retention and follow the
upstream cleanup procedure when retiring a job. Package removal does not remove
replication slots or target data.

Upstream release: https://github.com/pgrundev/pgsync/releases/tag/v0.1.1
