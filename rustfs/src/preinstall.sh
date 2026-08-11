#!/bin/sh

if ! getent group rustfs >/dev/null 2>&1; then
    groupadd -r rustfs || exit 1
fi
if ! getent passwd rustfs >/dev/null 2>&1; then
    useradd -r -g rustfs -d /var/lib/rustfs -M -s /sbin/nologin -c "RustFS service" rustfs || exit 1
fi

exit 0
