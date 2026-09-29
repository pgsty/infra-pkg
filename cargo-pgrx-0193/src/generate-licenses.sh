#!/bin/sh
set -eu

vendor=${1:?vendor directory is required}
output=${2:?output path is required}

tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT HUP INT TERM

find "$vendor" -maxdepth 2 -type f \( -iname 'LICENSE*' -o -iname 'COPYING*' -o -iname 'COPYRIGHT*' -o -iname 'NOTICE*' \) | LC_ALL=C sort > "$tmp"
test -s "$tmp" || { echo "no vendored legal documents found" >&2; exit 1; }

: > "$output"
while IFS= read -r legal; do
    printf '\n===== %s =====\n\n' "$legal" >> "$output"
    cat "$legal" >> "$output"
    printf '\n' >> "$output"
done < "$tmp"
