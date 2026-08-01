#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "postinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/keepalived_exporter.service 1.7.1-2~ keepalived-exporter -- "$@" || exit 1
fi

# Normalize metadata inherited from historical packages.
if [ -e /etc/default/keepalived_exporter ]; then
    chown root:root /etc/default/keepalived_exporter || exit 1
    chmod 0644 /etc/default/keepalived_exporter || exit 1
fi

if command -v systemctl >/dev/null 2>&1; then
    systemctl daemon-reload >/dev/null 2>&1 || :
fi

case "$1" in
    1)
        if command -v systemctl >/dev/null 2>&1; then
            systemctl --no-reload preset keepalived_exporter.service >/dev/null 2>&1 || :
        fi
        ;;
esac

exit 0
