# cargo-pgrx-0191

This recipe builds the exact `cargo-pgrx` 0.19.1 Cargo plugin slot from the
published `.crate`, its `Cargo.lock`, and a checksum-pinned vendor archive.

```text
/usr/lib/pgsty/cargo-pgrx/0.19.1/bin/cargo-pgrx
/usr/bin/cargo-pgrx-0191
```

The wrapper uses the single current `rust-toolchain` package at
`/usr/lib/pgsty/rust` and defaults `PGRX_HOME` to `$HOME/.pgrx/0.19.1`.
Package builds should override PGRX_HOME with a build-local directory.

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
