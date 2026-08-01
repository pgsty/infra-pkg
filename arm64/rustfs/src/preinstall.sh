#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "preinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/rustfs.service 1.0.0-b12~ rustfs -- "$@" || exit 1
fi

if ! getent group rustfs >/dev/null 2>&1; then
    groupadd -r rustfs || exit 1
fi
if ! getent passwd rustfs >/dev/null 2>&1; then
    useradd -r -g rustfs -d /var/lib/rustfs -M -s /sbin/nologin -c "RustFS service" rustfs || exit 1
fi

exit 0
