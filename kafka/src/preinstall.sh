#!/bin/sh

if [ "${DPKG_MAINTSCRIPT_NAME:-}" = "preinst" ] && command -v dpkg-maintscript-helper >/dev/null 2>&1; then
    dpkg-maintscript-helper rm_conffile /lib/systemd/system/kafka.service 4.3.1-2~ kafka -- "$@" || exit 1
fi

if ! getent group kafka >/dev/null 2>&1; then
    groupadd -r kafka || exit 1
fi
if ! getent passwd kafka >/dev/null 2>&1; then
    useradd -r -g kafka -d /var/lib/kafka -M -s /sbin/nologin -c "Apache Kafka service" kafka || exit 1
fi

exit 0
