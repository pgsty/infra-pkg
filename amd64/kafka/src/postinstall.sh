#!/bin/sh

chown -R kafka:kafka /opt/kafka
chmod a+x /opt/kafka/bin/*.sh

# Handle script parameters
case "$1" in
    configure|1)
        # newly installed
        systemctl --no-reload preset service.service &>/dev/null || :
        ;;
    *)
        exit 0
        ;;
esac

exit 0