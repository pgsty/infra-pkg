# pgBackRest exporter 0.25.0

The upstream 0.25.0 release has no binary assets as checked on 2026-11-04.
This recipe builds the tagged source for Linux amd64 and arm64, using the
dependencies already present in the upstream `vendor/` directory.

- Tag: `v0.25.0`
- Commit: `4cf845c0bd1caad5d5b8f12b20513b68a4ee226a`
- Toolchain: Go 1.27.3, with `CGO_ENABLED=0`
- Source SHA256: `2f09cda98c672d23ab4a74b8aff39ead71129f790dfc1357a1e994b8fe2502e2`

The archive checksum is recorded locally from the commit-specific source URL;
it is not an upstream binary checksum. The source archive is cached under
`tarball/pgbackrest-exporter-0.25.0-source.tar.gz`. Downloads default to the
port 8888 proxy and can be overridden with `PROXY`.

Run `make pgbackrest-exporter` from the repository root to build all four
RPM/DEB packages. Compilation uses `-mod=vendor`, `GOPROXY=off`,
`GOSUMDB=off`, and `GOTOOLCHAIN=local`; it requires the pinned local Go
toolchain and does not fetch dependencies. Version, revision, build user and
build date are fixed, with paths trimmed and the build ID omitted.

On 2026-11-04, upstream unit tests passed with `make -C pgbackrest-exporter test`.
Independent builds in a separate directory produced the same binary hashes
as both RPM and DEB payloads. The binaries also returned version 0.25.0 when
executed in matching Linux containers.

Upstream 0.25.0 fixes database-count metrics for the selected latest
incremental backup and waits for parallel queries before completing collection.
Its service template now defaults to the `postgres` user/group. This package
continues to use its existing unit with `User=root`; administrators can select
an appropriate service account with a systemd override matching their
pgBackRest configuration. Installing this package does not install or
configure pgBackRest, restart the exporter, or change service credentials.

Sources:

- [Release notes](https://github.com/woblerr/pgbackrest_exporter/releases/tag/v0.25.0)
- [Pinned source](https://github.com/woblerr/pgbackrest_exporter/tree/4cf845c0bd1caad5d5b8f12b20513b68a4ee226a)
