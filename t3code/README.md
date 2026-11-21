# T3 Code desktop packages

`make t3-code` (alias of `make t3code`) builds amd64 and arm64 packages.
The package and desktop executable are named `t3code`, matching upstream.

Upstream [v0.1.11](https://github.com/pingdotgg/t3code/releases/tag/v0.1.11)
publishes DEB packages for both architectures but no RPM. The recipe preserves
the official DEBs byte for byte and uses their verified payloads to create
`t3code-0.1.11-1PGSTY` RPMs with nFPM. SHA256 pins come from GitHub release asset
digests. Building requires `dpkg-deb` and the repository's pinned nFPM.
Output DEBs use `t3code_0.1.11_<arch>.deb` filenames for the repository's stash
workflow; renaming does not change their contents or native metadata.

The RPM keeps `/opt/T3 Code (Beta)`, desktop entries, icons, bundled runtime,
native modules and third-party notices. It owns `/usr/bin/t3code` directly,
installs Chromium's sandbox as root:root 04755, and refreshes the desktop cache
without launching the app or configuring a user account. The standalone `t3`
server archive is not a separate package in this recipe.

Both architectures include core helpers requiring glibc 2.34; the RPM declares
that minimum (EL9 or newer, not EL8). The optional KDE screenshot helper requires
glibc 2.39 and a matching KDE environment. The optional Cursor sandbox on
arm64 also requires glibc 2.39. The original DEB metadata is unchanged;
use a sufficiently recent distribution there too. These are desktop packages,
so a graphical session and configured agent providers are needed for normal use.

Use APT/DNF for package updates. Upstream's desktop updater may offer DEB updates;
there is no upstream RPM update asset. Keep user state and credentials in the
application's normal per-user directories.

Upstream includes both Linux architectures of the optional `node-pty` prebuilds.
Its loader selects the directory using `process.platform` and `process.arch`;
the matching native module is present in each package. Preserve these upstream
files when repackaging the desktop runtime.
