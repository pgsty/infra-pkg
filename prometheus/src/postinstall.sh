#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "postinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/prometheus.service 3.13.2-1~ prometheus -- "$@"
fi

# Normalize metadata inherited from historical packages.
case "$(stat -c '%U:%G:%a' /etc/default/prometheus 2>/dev/null)" in
    root:root:700|prometheus:prometheus:700)
        chown root:root /etc/default/prometheus || exit 1
        chmod 0644 /etc/default/prometheus || exit 1
        ;;
esac
case "$(stat -c '%U:%G:%a' /etc/prometheus 2>/dev/null)" in
    root:root:700|prometheus:prometheus:700)
        chown root:prometheus /etc/prometheus || exit 1
        chmod 0750 /etc/prometheus || exit 1
        ;;
esac
case "$(stat -c '%U:%G:%a' /etc/prometheus/prometheus.yml 2>/dev/null)" in
    root:root:700|prometheus:prometheus:700)
        chown root:prometheus /etc/prometheus/prometheus.yml || exit 1
        chmod 0640 /etc/prometheus/prometheus.yml || exit 1
        ;;
esac

if command -v systemctl >/dev/null 2>&1; then
    systemctl daemon-reload >/dev/null 2>&1 || :
fi

case "$1" in
    1)
        if command -v systemctl >/dev/null 2>&1; then
            systemctl --no-reload preset prometheus.service >/dev/null 2>&1 || :
        fi
        ;;
esac

exit 0
