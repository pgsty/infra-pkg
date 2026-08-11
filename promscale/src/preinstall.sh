#!/bin/sh

if ! getent group promscale >/dev/null 2>&1; then
    groupadd -r promscale || exit 1
fi
if ! getent passwd promscale >/dev/null 2>&1; then
    useradd -r -g promscale -d /var/lib/promscale -M -s /sbin/nologin -c "Promscale service" promscale || exit 1
fi

exit 0
