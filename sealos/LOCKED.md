# Sealos version lock

This PGSTY package is intentionally frozen at Sealos v5.0.1. It is the last
stable upstream release published under the Apache License 2.0.

Upstream replaced Apache-2.0 with the Sealos Sustainable Use License in commit
`08f35fdb9fffe19e4a0c854451e4eea17077d781`, before publishing v5.1.0. That
license restricts commercial cloud use and redistribution, so v5.1.0 and later
releases are not eligible for this package.

This is an obsolete, locked package. It receives no automatic upstream version
updates. The package installs only the `sealos` CLI, matching the payload of the
upstream native Linux packages; helper binaries present in the release archive
are not installed.
