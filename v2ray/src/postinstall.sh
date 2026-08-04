#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "postinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/v2ray.service 5.51.2-2~ vray -- "$@" || exit 1
fi

# Migrate only the exact release-1 metadata needed by the dedicated service user.
if [ -e /etc/v2ray.json ] && [ "$(stat -c '%U:%G:%a' /etc/v2ray.json 2>/dev/null)" = "root:root:644" ]; then
    chown root:v2ray /etc/v2ray.json || exit 1
    chmod 0640 /etc/v2ray.json || exit 1
fi
if [ -d /var/log/v2ray ] && [ "$(stat -c '%U:%G:%a' /var/log/v2ray 2>/dev/null)" = "root:root:755" ]; then
    chown v2ray:v2ray /var/log/v2ray || exit 1
    chmod 0750 /var/log/v2ray || exit 1
fi

if command -v systemctl >/dev/null 2>&1; then
    systemctl daemon-reload >/dev/null 2>&1 || :
fi

exit 0
