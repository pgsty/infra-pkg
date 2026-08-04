#!/bin/sh

case "$1" in
    remove)
        if command -v systemctl >/dev/null 2>&1; then
            systemctl stop loki.service >/dev/null 2>&1 || :
        fi
        ;;
    0)
        if command -v systemctl >/dev/null 2>&1; then
            systemctl --no-reload disable --now loki.service >/dev/null 2>&1 || :
        fi
        ;;
esac

exit 0
