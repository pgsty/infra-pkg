#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "postinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/rustfs.service 1.0.0-b12~ rustfs -- "$@" || exit 1
fi

if [ -d /etc/default ] && [ "$(stat -c '%U:%G:%a' /etc/default 2>/dev/null)" = "rustfs:rustfs:755" ]; then
    chown root:root /etc/default || exit 1
fi
if [ -e /etc/default/rustfs ] && [ "$(stat -c '%U:%G:%a' /etc/default/rustfs 2>/dev/null)" = "rustfs:rustfs:640" ]; then
    chown root:root /etc/default/rustfs || exit 1
fi

if command -v systemctl >/dev/null 2>&1; then
    systemctl daemon-reload >/dev/null 2>&1 || :
fi

case "$1" in
    1)
        if command -v systemctl >/dev/null 2>&1; then
            systemctl --no-reload preset rustfs.service >/dev/null 2>&1 || :
        fi
        ;;
esac

exit 0
