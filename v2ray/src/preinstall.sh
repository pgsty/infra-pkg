#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "preinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/v2ray.service 5.51.2-2~ vray -- "$@" || exit 1
fi

if ! getent group v2ray >/dev/null 2>&1; then
    groupadd -r v2ray || exit 1
fi
if ! getent passwd v2ray >/dev/null 2>&1; then
    useradd -r -g v2ray -d /var/lib/v2ray -M -s /sbin/nologin -c "V2Ray service" v2ray || exit 1
fi

exit 0
