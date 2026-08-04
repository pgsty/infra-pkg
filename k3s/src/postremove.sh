#!/bin/sh

case "$1" in
    purge)
        rm -f /etc/systemd/system/multi-user.target.wants/k3s.service
        rm -f /etc/systemd/system/multi-user.target.wants/k3s-agent.service
        ;;
esac

if command -v systemctl >/dev/null 2>&1; then
    systemctl daemon-reload >/dev/null 2>&1 || :
fi

exit 0
