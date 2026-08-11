#!/bin/sh

if ! getent group prometheus >/dev/null 2>&1; then
    groupadd -r prometheus || exit 1
fi
if ! getent passwd prometheus >/dev/null 2>&1; then
    useradd -r -g prometheus -s /sbin/nologin -c "Prometheus services" prometheus || exit 1
fi

exit 0
