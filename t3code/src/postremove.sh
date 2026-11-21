#!/bin/sh
set -eu

# The RPM owns /usr/bin/t3code; never remove it from an upgrade scriptlet.
if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database /usr/share/applications || true
fi
