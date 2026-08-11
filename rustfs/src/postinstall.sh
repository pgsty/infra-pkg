#!/bin/sh

if command -v systemctl >/dev/null 2>&1; then
    systemctl daemon-reload >/dev/null 2>&1 || :
fi

case "${1:-}:${2:-}" in
    1:*|configure:)
        if command -v systemctl >/dev/null 2>&1; then
            systemctl --no-reload preset rustfs.service >/dev/null 2>&1 || :
        fi
        ;;
esac

exit 0
