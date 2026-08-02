#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "preinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/promtail.service 3.6.7-2~ promtail -- "$@" || exit 1
fi

exit 0
