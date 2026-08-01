#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "postinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/blackbox_exporter.service 0.28.0-2~ blackbox-exporter -- "$@" || exit 1
fi

# Normalize metadata inherited from historical packages.
if [ -e /etc/blackbox.yml ]; then
    chown root:prometheus /etc/blackbox.yml || exit 1
    chmod 0640 /etc/blackbox.yml || exit 1
fi
if [ -e /etc/default/blackbox_exporter ]; then
    chown root:root /etc/default/blackbox_exporter || exit 1
    chmod 0644 /etc/default/blackbox_exporter || exit 1
fi

if command -v systemctl >/dev/null 2>&1; then
    systemctl daemon-reload >/dev/null 2>&1 || :
fi

case "$1" in
    1)
        if command -v systemctl >/dev/null 2>&1; then
            systemctl --no-reload preset blackbox_exporter.service >/dev/null 2>&1 || :
        fi
        ;;
esac

exit 0
