#!/bin/sh

# create a group & user named prometheus if not exists
getent group kafka >/dev/null || groupadd -r kafka -g 9092 ; /bin/true
getent passwd kafka >/dev/null || useradd -r -u 9092 -g kafka -s /sbin/nologin -c "kafka services" kafka
exit 0