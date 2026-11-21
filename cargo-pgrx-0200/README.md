# cargo-pgrx-0200

This recipe builds the exact `cargo-pgrx` 0.20.0 Cargo plugin slot from the
published `.crate`, its `Cargo.lock`, and a checksum-pinned vendor archive.

```text
/usr/lib/pgsty/cargo-pgrx/0.20.0/bin/cargo-pgrx
/usr/bin/cargo-pgrx-0200
```

The wrapper uses the single current `rust-toolchain` package at
`/usr/lib/pgsty/rust` and defaults `PGRX_HOME` to `$HOME/.pgrx/0.20.0`.
Package builds should override PGRX_HOME with a build-local directory.

The package requires `rust-toolchain >= 1.99.1`, matching the upstream
minimum Rust version. The release artifacts are built with Rust 1.100.0.
The existing 0191, 0192 and 0193 slots remain independently installable.

The binary is built natively on the oldest supported GNU/Linux ABI baseline:

```text
EL8, GLIBC 2.28
```

`--frozen` builds the locked dependency graph offline. Upstream 0.20.0
always uses Rustls with the platform certificate store and no longer has
`rustls` or `native-tls` Cargo features. The resulting ELF must depend only on
glibc and libgcc, remain at or below the configured GLIBC/GCC symbol ceilings,
and pass the full target matrix before entering generic INFRA.

The locked vendor bundle can be regenerated on a Linux builder with the
packaged Rust toolchain:

```bash
make vendor-bundle
```

The generated archive must reproduce the pinned SHA256. Builds from the bundle
are offline and Cargo verifies each vendored crate checksum from Cargo.lock.
BUILDINFO, ELF ABI data, Cargo metadata, and third-party license material are
included in every RPM and DEB.

This package is not FIPS-certified. Environments requiring a validated FIPS
TLS implementation must not use cargo-pgrx's Rustls download path without a
separate policy decision; normal PGSTY builds use installed `pg_config` paths.

Version 0.20.0 supports PostgreSQL 15 through 19; PostgreSQL 13 and 14
are no longer supported. Keep a matching older cargo-pgrx slot for extensions
that have not migrated their pgrx dependencies.

Extension builds require PostgreSQL development headers, a host C compiler,
and a `clang` driver matching the major version of `libclang`. Use the same
LLVM release for `llvm-ar`. On Debian/Ubuntu install `clang llvm libclang-dev`;
on RHEL-compatible builders install `clang llvm` and the PostgreSQL development
package for the selected major. These are extension build prerequisites; the
CLI can be installed without selecting a PostgreSQL major or LLVM toolset.

`cargo-pgrx` uses system `tar` to unpack downloaded PostgreSQL `.tar.gz`
archives, so this package explicitly depends on `tar` and `gzip`.

The CVE-2026-6460 fix also requires rebuilding each extension against patched
PostgreSQL headers (15.20, 16.16, 17.12, 18.7 or 19rc2). Those rebuilt
extensions cannot load on earlier PostgreSQL minor releases. See the
[upstream migration guide](https://github.com/pgcentralfoundation/pgrx/blob/v0.20.0/v0.20.0-MIGRATION.md)
for the API and build changes.
