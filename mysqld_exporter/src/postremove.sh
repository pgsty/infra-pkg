#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "postrm" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/mysqld_exporter.service 0.19.0-2~ mysqld-exporter -- "$@" || exit 1
fi

case "$1" in
    purge)
        if [ -L /etc/systemd/system/multi-user.target.wants/mysqld_exporter.service ]; then
            rm -f /etc/systemd/system/multi-user.target.wants/mysqld_exporter.service || exit 1
        fi
        if command -v systemctl >/dev/null 2>&1; then
            systemctl daemon-reload >/dev/null 2>&1 || :
        fi
        ;;
    remove|0)
        if command -v systemctl >/dev/null 2>&1; then
            systemctl daemon-reload >/dev/null 2>&1 || :
        fi
        ;;
esac

exit 0
