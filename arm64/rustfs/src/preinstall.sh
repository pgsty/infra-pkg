#!/bin/sh

# create a group & user named rustfs if not exists
getent group rustfs >/dev/null || groupadd -r rustfs ; /bin/true
getent passwd rustfs >/dev/null || useradd -r -g rustfs -s /sbin/nologin -c "RustFS services" rustfs

exit 0
