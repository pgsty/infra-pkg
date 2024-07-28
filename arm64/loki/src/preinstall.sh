#!/bin/sh

# create a group & user named prometheus if not exists
getent group loki >/dev/null || groupadd -r loki ; /bin/true
getent passwd loki >/dev/null || useradd -r -g loki -s /sbin/nologin -c "Loki Logging Service" loki
exit 0