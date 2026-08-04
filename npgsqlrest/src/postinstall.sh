#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "postinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/npgsqlrest.service 3.21.0-2~ npgsqlrest -- "$@" || exit 1
fi

# Migrate only the exact release-1 metadata needed by the unprivileged unit.
if [ -d /etc/npgsqlrest ] && [ "$(stat -c '%U:%G:%a' /etc/npgsqlrest 2>/dev/null)" = "root:root:755" ]; then
    chown root:npgsqlrest /etc/npgsqlrest || exit 1
    chmod 0750 /etc/npgsqlrest || exit 1
fi
if [ -e /etc/npgsqlrest/appsettings.json ] && [ "$(stat -c '%U:%G:%a' /etc/npgsqlrest/appsettings.json 2>/dev/null)" = "root:root:640" ]; then
    chown root:npgsqlrest /etc/npgsqlrest/appsettings.json || exit 1
    chmod 0640 /etc/npgsqlrest/appsettings.json || exit 1
fi

if command -v systemctl >/dev/null 2>&1; then
    systemctl daemon-reload >/dev/null 2>&1 || :
fi

case "$1" in
    1)
        if command -v systemctl >/dev/null 2>&1; then
            systemctl --no-reload preset npgsqlrest.service >/dev/null 2>&1 || :
        fi
        ;;
esac

exit 0
