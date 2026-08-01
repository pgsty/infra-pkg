#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "preinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/pgbackrest_exporter.service 0.24.0-1~ pgbackrest-exporter -- "$@" || exit 1
fi

exit 0
