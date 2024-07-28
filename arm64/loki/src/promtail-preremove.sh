#!/bin/sh

case "$1" in
    remove|0)
        systemctl --no-reload disable --now promtail.service &>/dev/null || :
        ;;
    *)
        exit 0
        ;;
esac

exit 0