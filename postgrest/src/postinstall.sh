#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "postinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/postgrest.service 14.16.0-2~ postgrest -- "$@" || exit 1
fi

# Migrate only the exact release-1 metadata needed by the unprivileged unit.
if [ -d /etc/postgrest ] && [ "$(stat -c '%U:%G:%a' /etc/postgrest 2>/dev/null)" = "root:root:755" ]; then
    chown root:postgrest /etc/postgrest || exit 1
    chmod 0750 /etc/postgrest || exit 1
fi
if [ -e /etc/postgrest/postgrest.conf ] && [ "$(stat -c '%U:%G:%a' /etc/postgrest/postgrest.conf 2>/dev/null)" = "root:root:640" ]; then
    chown root:postgrest /etc/postgrest/postgrest.conf || exit 1
    chmod 0640 /etc/postgrest/postgrest.conf || exit 1
fi

if command -v systemctl >/dev/null 2>&1; then
    systemctl daemon-reload >/dev/null 2>&1 || :
fi

case "$1" in
    1)
        if command -v systemctl >/dev/null 2>&1; then
            systemctl --no-reload preset postgrest.service >/dev/null 2>&1 || :
        fi
        ;;
esac

exit 0
