#!/bin/sh

case "$1" in
    purge)
        if [ -L /etc/systemd/system/multi-user.target.wants/k3s.service ]; then
            rm -f /etc/systemd/system/multi-user.target.wants/k3s.service || exit 1
        fi
        if [ -L /etc/systemd/system/multi-user.target.wants/k3s-agent.service ]; then
            rm -f /etc/systemd/system/multi-user.target.wants/k3s-agent.service || exit 1
        fi
        ;;
esac

if command -v systemctl >/dev/null 2>&1; then
    systemctl daemon-reload >/dev/null 2>&1 || :
fi

exit 0
