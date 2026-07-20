#!/bin/sh

case "$1" in
    remove|0)
        if command -v systemctl >/dev/null 2>&1; then
            systemctl disable --now k3s.service k3s-agent.service >/dev/null 2>&1 || :
        fi
        if [ -x /usr/bin/k3s-killall.sh ]; then
            /usr/bin/k3s-killall.sh >/dev/null 2>&1 || :
        fi
        ;;
esac

exit 0
