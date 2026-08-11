#!/bin/sh

case "$1" in
    purge)
        if [ -L /etc/systemd/system/multi-user.target.wants/v2ray.service ]; then
            rm -f /etc/systemd/system/multi-user.target.wants/v2ray.service || exit 1
        fi
        if command -v systemctl >/dev/null 2>&1; then
            systemctl daemon-reload >/dev/null 2>&1 || :
        fi
        ;;
    remove|0)
        if command -v systemctl >/dev/null 2>&1; then
            systemctl daemon-reload >/dev/null 2>&1 || :
        fi
        ;;
esac

exit 0
