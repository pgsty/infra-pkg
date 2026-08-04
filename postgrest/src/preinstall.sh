#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "preinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/postgrest.service 14.16.0-2~ postgrest -- "$@" || exit 1
fi

if ! getent group postgrest >/dev/null 2>&1; then
    groupadd -r postgrest || exit 1
fi
if ! getent passwd postgrest >/dev/null 2>&1; then
    useradd -r -g postgrest -d /var/lib/postgrest -M -s /sbin/nologin -c "PostgREST service" postgrest || exit 1
fi

exit 0
