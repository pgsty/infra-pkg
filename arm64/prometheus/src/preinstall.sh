#!/bin/sh

# Retire the historical Debian conffile before installing the vendor unit.
if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "preinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/prometheus.service 3.13.2-1~ prometheus -- "$@"
fi

if ! getent group prometheus >/dev/null 2>&1; then
    groupadd -r prometheus || exit 1
fi
if ! getent passwd prometheus >/dev/null 2>&1; then
    useradd -r -g prometheus -d /var/lib/prometheus -M -s /sbin/nologin -c "Prometheus services" prometheus || exit 1
fi

exit 0
