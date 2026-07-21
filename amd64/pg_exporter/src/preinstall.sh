#!/bin/bash

# create a group & user named prometheus if not exists
# home is set to /var/lib/prometheus (where libpq looks for ~/.pgpass),
# but the directory itself is not created by this package
getent group prometheus >/dev/null || groupadd -r prometheus ; /bin/true
getent passwd prometheus >/dev/null || useradd -r -g prometheus -s /sbin/nologin -c "Prometheus services" -d /var/lib/prometheus prometheus
exit 0
