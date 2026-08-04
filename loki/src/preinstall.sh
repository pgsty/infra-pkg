#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "preinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/loki.service 3.6.7-2~ loki -- "$@" || exit 1
fi

if ! getent group loki >/dev/null 2>&1; then
    groupadd -r loki || exit 1
fi
if ! getent passwd loki >/dev/null 2>&1; then
    useradd -r -g loki -d /var/lib/loki -M -s /sbin/nologin -c "Loki logging service" loki || exit 1
fi

exit 0
