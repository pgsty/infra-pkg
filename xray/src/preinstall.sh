#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "preinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/xray.service 26.3.27-2~ xray -- "$@" || exit 1
fi

if ! getent group xray >/dev/null 2>&1; then
    groupadd -r xray || exit 1
fi
if ! getent passwd xray >/dev/null 2>&1; then
    useradd -r -g xray -d /var/lib/xray -M -s /sbin/nologin -c "Xray service" xray || exit 1
fi

exit 0
