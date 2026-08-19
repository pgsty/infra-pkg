# rust-toolchain

This recipe repackages the checksum-pinned and GPG-verified Rust 1.97.1
standalone GNU/Linux toolchain. It installs `rustc`, the native standard
library, Cargo, and rustfmt under the stable private prefix:

```text
/usr/lib/pgsty/rust
```

`rust-toolchain` is the single current PGSTY Rust package. Normal package
upgrades replace the previous version; parallel Rust slots are intentionally
not supported. The package does not own `/usr/bin/rustc`, `/usr/bin/cargo`, or
the distro `rust`/`cargo` package names.

```bash
rust-toolchain rustc -vV
rust-toolchain cargo build --locked
PATH=/usr/lib/pgsty/rust/bin:$PATH cargo -V
```

The official archive is built for a glibc 2.17 baseline. The recipe verifies
the upstream release signature, pins the signing-key fingerprint, and scans
every installed ELF for unexpected dynamic dependencies and newer GLIBC
symbols before producing RPM and DEB artifacts.

To build one or both architectures:

```bash
make ARCH=arm64 one
make ARCH=amd64 one
make all
```

`RUST_DIST_SERVER` may point at a trusted mirror, but the pinned upstream
SHA256 and Rust release signature remain authoritative. Rust security support
tracks upstream's current stable release policy, so this package needs an
explicit upgrade and compatibility-test cadence.
