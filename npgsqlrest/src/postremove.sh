#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "postrm" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/npgsqlrest.service 3.21.0-2~ npgsqlrest -- "$@" || exit 1
fi

case "$1" in
    purge)
        if [ -L /etc/systemd/system/multi-user.target.wants/npgsqlrest.service ]; then
            rm -f /etc/systemd/system/multi-user.target.wants/npgsqlrest.service || exit 1
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
