# Sealos version lock

**LOCKED / 锁定: v5.0.1 (Apache-2.0). No further upstream updates.**

On 2026-11-21 the user explicitly restored the permanent lock to
[v5.0.1](https://github.com/labring/sealos/releases/tag/v5.0.1), the previously
selected final stable release under the
[Apache License 2.0](https://github.com/labring/sealos/blob/v5.0.1/LICENSE).
This supersedes the temporary vendor-direct policy used for v5.1.1 and v5.1.2.

Upstream replaced Apache-2.0 with the Sealos Sustainable Use License in commit
`08f35fdb9fffe19e4a0c854451e4eea17077d781`, before v5.1.0. Those later releases
are excluded even if their native RPM metadata still declares Apache 2.0.

The recipe restores the PGSTY nFPM package using the original checksum-pinned
amd64 and arm64 v5.0.1 archives. Release `2PGSTY` records this packaging policy
change. It installs only `/usr/bin/sealos`, the Apache license and package
documentation; the archive's helper binaries are not installed.

`LOCKED_VERSION=5.0.1` in the Makefile is the machine-readable lock. Version
scans report this package as **locked**; single-package and batch updaters
skip it, including forced batch updates. The build and recipe linter reject
a version that differs from the lock. General requests to update all packages
do not remove this lock. Only an explicit user request to unlock Sealos may
change this policy.

Existing newer packages and published repository contents are separate from
this recipe rollback. Repository import, client downgrade and publication must
be handled explicitly; building v5.0.1 does not downgrade installed v5.1.x.
