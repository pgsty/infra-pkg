#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "postinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/mysqld_exporter.service 0.19.0-2~ mysqld-exporter -- "$@" || exit 1
fi

if command -v systemctl >/dev/null 2>&1; then
    systemctl daemon-reload >/dev/null 2>&1 || :
fi

case "$1" in
    1)
        if command -v systemctl >/dev/null 2>&1; then
            systemctl --no-reload preset mysqld_exporter.service >/dev/null 2>&1 || :
        fi
        ;;
esac

exit 0
