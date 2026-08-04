#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "preinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/npgsqlrest.service 3.21.0-2~ npgsqlrest -- "$@" || exit 1
fi

if ! getent group npgsqlrest >/dev/null 2>&1; then
    groupadd -r npgsqlrest || exit 1
fi
if ! getent passwd npgsqlrest >/dev/null 2>&1; then
    useradd -r -g npgsqlrest -d /var/lib/npgsqlrest -M -s /sbin/nologin -c "NpgsqlRest service" npgsqlrest || exit 1
fi

exit 0
