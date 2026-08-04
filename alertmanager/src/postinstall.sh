#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "postinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/alertmanager.service 0.33.1-2~ alertmanager -- "$@" || exit 1
fi

# Normalize metadata inherited from historical packages.
case "$(stat -c '%U:%G:%a' /etc/default/alertmanager 2>/dev/null)" in
    root:root:700|prometheus:prometheus:700)
        chown root:root /etc/default/alertmanager || exit 1
        chmod 0644 /etc/default/alertmanager || exit 1
        ;;
esac
case "$(stat -c '%U:%G:%a' /etc/alertmanager.yml 2>/dev/null)" in
    root:root:700|prometheus:prometheus:700)
        chown root:prometheus /etc/alertmanager.yml || exit 1
        chmod 0640 /etc/alertmanager.yml || exit 1
        ;;
esac

if command -v systemctl >/dev/null 2>&1; then
    systemctl daemon-reload >/dev/null 2>&1 || :
fi

case "$1" in
    1)
        if command -v systemctl >/dev/null 2>&1; then
            systemctl --no-reload preset alertmanager.service >/dev/null 2>&1 || :
        fi
        ;;
esac

exit 0
