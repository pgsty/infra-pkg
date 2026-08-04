#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "preinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/keepalived_exporter.service 1.7.1-2~ keepalived-exporter -- "$@" || exit 1
fi

exit 0
