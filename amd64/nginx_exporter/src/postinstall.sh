#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "postinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/nginx_exporter.service 1.5.1-2~ nginx-exporter -- "$@" || exit 1
fi

# Normalize metadata inherited from historical packages.
if [ -e /etc/default/nginx_exporter ]; then
    chown root:root /etc/default/nginx_exporter || exit 1
    chmod 0644 /etc/default/nginx_exporter || exit 1
fi

if command -v systemctl >/dev/null 2>&1; then
    systemctl daemon-reload >/dev/null 2>&1 || :
fi

case "$1" in
    1)
        if command -v systemctl >/dev/null 2>&1; then
            systemctl --no-reload preset nginx_exporter.service >/dev/null 2>&1 || :
        fi
        ;;
esac

exit 0
