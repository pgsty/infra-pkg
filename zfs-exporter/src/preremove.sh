#!/bin/sh

case "$1" in
    remove)
        if command -v systemctl >/dev/null 2>&1; then
            systemctl stop zfs_exporter.service >/dev/null 2>&1 || :
        fi
        ;;
    0)
        if command -v systemctl >/dev/null 2>&1; then
            systemctl --no-reload disable --now zfs_exporter.service >/dev/null 2>&1 || :
        fi
        ;;
esac

exit 0
