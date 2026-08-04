#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "preinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/alertmanager.service 0.33.1-2~ alertmanager -- "$@" || exit 1
fi

if ! getent group prometheus >/dev/null 2>&1; then
    groupadd -r prometheus || exit 1
fi
if ! getent passwd prometheus >/dev/null 2>&1; then
    useradd -r -g prometheus -s /sbin/nologin -c "Prometheus services" prometheus || exit 1
fi

exit 0
