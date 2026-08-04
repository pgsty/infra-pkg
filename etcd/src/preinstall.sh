#!/bin/sh

if ! getent group etcd >/dev/null 2>&1; then
    groupadd -r etcd || exit 1
fi
if ! getent passwd etcd >/dev/null 2>&1; then
    useradd -r -g etcd -d /var/lib/etcd -M -s /sbin/nologin -c "etcd service" etcd || exit 1
fi

exit 0
