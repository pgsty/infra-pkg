#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "postinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/xray.service 26.3.27-2~ xray -- "$@" || exit 1
fi

# Migrate only the exact release-1 metadata needed by the dedicated service user.
if [ -e /etc/xray.json ] && [ "$(stat -c '%U:%G:%a' /etc/xray.json 2>/dev/null)" = "root:root:644" ]; then
    chown root:xray /etc/xray.json || exit 1
    chmod 0640 /etc/xray.json || exit 1
fi
if [ -d /var/log/xray ] && [ "$(stat -c '%U:%G:%a' /var/log/xray 2>/dev/null)" = "root:root:755" ]; then
    chown xray:xray /var/log/xray || exit 1
    chmod 0750 /var/log/xray || exit 1
fi

if command -v systemctl >/dev/null 2>&1; then
    systemctl daemon-reload >/dev/null 2>&1 || :
fi

exit 0
