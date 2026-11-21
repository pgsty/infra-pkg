# cargo-pgrx-0194

This recipe builds the exact `cargo-pgrx` 0.19.4 Cargo plugin slot from the
published `.crate`, its `Cargo.lock`, and a checksum-pinned vendor archive.

```text
/usr/lib/pgsty/cargo-pgrx/0.19.4/bin/cargo-pgrx
/usr/bin/cargo-pgrx-0194
```

The wrapper uses the single current `rust-toolchain` package at
`/usr/lib/pgsty/rust` and defaults `PGRX_HOME` to `$HOME/.pgrx/0.19.4`.
Package builds should override PGRX_HOME with a build-local directory.

The package requires `rust-toolchain >= 1.96.0`, matching the upstream
minimum Rust version. The release artifacts are built with Rust 1.100.0.
The existing 0191, 0192 and 0193 slots remain independently installable.

The binary is built natively on the oldest supported GNU/Linux ABI baseline:

```text
EL8, GLIBC 2.28
```

`--frozen --no-default-features` retains ureq's explicit Rustls and platform
verifier features while omitting the cargo-pgrx feature that also enables
native-tls. The resulting ELF must depend only on glibc and libgcc, remain at
or below the configured GLIBC/GCC symbol ceilings, and pass the full target
matrix before entering generic INFRA.

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

Version 0.19.4 is the final 0.19 release and includes the CVE-2026-6460
fix. To apply it to an extension, update its pgrx dependencies to 0.19.4
and rebuild against patched PostgreSQL headers (14.25, 15.20, 16.16, 17.12,
18.7 or 19rc2). Such extensions cannot load on earlier PostgreSQL minor
releases. Installing this CLI alone does not update an existing extension.

The CLI also uses system `tar` and `gzip` when creating cross-compilation
target bundles, so both are declared as package dependencies. PostgreSQL
development headers and LLVM remain extension build prerequisites selected
for the target PostgreSQL major.
