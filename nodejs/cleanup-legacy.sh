#!/bin/sh

legacy=/usr/local/node
if [ -d "$legacy" ] && [ ! -L "$legacy" ]; then
    find "$legacy" -depth -type d -empty -delete 2>/dev/null || :
fi

exit 0
