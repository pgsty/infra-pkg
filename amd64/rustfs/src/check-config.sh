#!/bin/sh

set -eu

config=/etc/default/rustfs

fail() {
    echo "rustfs: $1" >&2
    exit 1
}

trim() {
    awk '
        { value = value (NR == 1 ? "" : "\n") $0 }
        END {
            sub(/^[[:space:]]+/, "", value)
            sub(/[[:space:]]+$/, "", value)
            printf "%s", value
        }
    '
}

case "${RUSTFS_ACCESS_KEY+x}:${RUSTFS_SECRET_KEY+x}:${RUSTFS_ACCESS_KEY_FILE+x}:${RUSTFS_SECRET_KEY_FILE+x}" in
    x:x::)
        access_key=$(printf '%s' "$RUSTFS_ACCESS_KEY" | trim)
        secret_key=$(printf '%s' "$RUSTFS_SECRET_KEY" | trim)
        ;;
    ::x:x)
        [ -f "$RUSTFS_ACCESS_KEY_FILE" ] && [ -r "$RUSTFS_ACCESS_KEY_FILE" ] ||
            fail "cannot read RUSTFS_ACCESS_KEY_FILE from $config"
        [ -f "$RUSTFS_SECRET_KEY_FILE" ] && [ -r "$RUSTFS_SECRET_KEY_FILE" ] ||
            fail "cannot read RUSTFS_SECRET_KEY_FILE from $config"
        access_key=$(trim < "$RUSTFS_ACCESS_KEY_FILE")
        secret_key=$(trim < "$RUSTFS_SECRET_KEY_FILE")
        ;;
    *)
        fail "set one complete credential pair in $config (direct values or files)"
        ;;
esac

[ -n "$access_key" ] && [ -n "$secret_key" ] ||
    fail "credentials in $config must not be empty"
[ "$access_key" != rustfsadmin ] && [ "$secret_key" != rustfsadmin ] ||
    fail "refusing the upstream public default credentials in $config"

exit 0
