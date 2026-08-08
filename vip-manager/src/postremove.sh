#!/bin/sh

case "$1" in
    purge)
        if [ -L /etc/systemd/system/multi-user.target.wants/vip-manager.service ]; then
            rm -f /etc/systemd/system/multi-user.target.wants/vip-manager.service || exit 1
        fi
        ;;
esac

if command -v systemctl >/dev/null 2>&1; then
    systemctl daemon-reload >/dev/null 2>&1 || :
fi

exit 0
