#!/bin/sh

case "$1" in
    remove|0)
        if command -v systemctl >/dev/null 2>&1; then
            systemctl --no-reload disable --now promscale.service >/dev/null 2>&1 || :
        fi
        ;;
esac

exit 0
