# cargo-pgrx-0201

This versioned Cargo plugin supports PostgreSQL 15–19 and requires `rust-toolchain >= 1.99.1`.
Invoke `cargo-pgrx-0201 --version` to check the installation. Its default
`PGRX_HOME` is `$HOME/.pgrx/0.20.1`. Set `PGRX_HOME` to override it.

The EL8 builds use the packaged Rust 1.100.0 toolchain, the published
`cargo-pgrx` 0.20.1 crate, and its `Cargo.lock`. To reproduce the pinned
dependency archive, run `make vendor-bundle` with GNU tar and zstd 1.5.7.
The release build works offline and checks the resulting ELF against glibc
2.28 and GCC 4.2 symbol ceilings. Each package ships `BUILDINFO` with the
input hashes, an ABI report, dependency metadata, and third-party licenses
under `/usr/share/doc/cargo-pgrx-0201/`.

Cross compilation uses a target bundle with `cargo pgrx package`. The upstream release removed `--target` and `cargo pgrx cross`. See the [upstream release](https://github.com/pgcentralfoundation/pgrx/releases/tag/v0.20.1).
