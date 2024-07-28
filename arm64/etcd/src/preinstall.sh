#!/bin/sh

getent group etcd >/dev/null || groupadd -r etcd
getent passwd etcd >/dev/null || useradd -r -g etcd -d /var/lib/etcd \
    -s /sbin/nologin -c "etcd user" etcd