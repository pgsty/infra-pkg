#!/bin/sh
set -eu

root=${1:?toolchain root is required}
glibc_ceiling=${2:?GLIBC ceiling is required}
gcc_ceiling=${3:?GCC ceiling is required}
report=${4:?report path is required}

command -v file >/dev/null
command -v readelf >/dev/null

elfs=$(mktemp)
details=$(mktemp)
trap 'rm -f "$elfs" "$details"' EXIT HUP INT TERM

version_le() {
    awk -v actual="$1" -v maximum="$2" 'BEGIN {
        split(actual, a, "."); split(maximum, m, ".");
        for (i = 1; i <= 3; i++) {
            if ((a[i] + 0) < (m[i] + 0)) exit 0;
            if ((a[i] + 0) > (m[i] + 0)) exit 1;
        }
        exit 0;
    }'
}

find "$root" -type f | LC_ALL=C sort | while IFS= read -r candidate; do
    description=$(file -b "$candidate") || {
        echo "cannot identify $candidate" >&2
        exit 1
    }
    case "$description" in
        ELF\ *) echo "$candidate" ;;
    esac
done > "$elfs"

test -s "$elfs" || { echo "no ELF files found under $root" >&2; exit 1; }

while IFS= read -r candidate; do
    echo "FILE $candidate" >> "$details"

    needed=$(readelf -d "$candidate" 2>/dev/null | sed -n 's/.*Shared library: \[\(.*\)\].*/\1/p')
    for library in $needed; do
        case "$library" in
            ld-linux-aarch64.so.1|ld-linux-x86-64.so.2|libc.so.6|libdl.so.2|libgcc_s.so.1|libm.so.6|libpthread.so.0|librt.so.1|libstdc++.so.6|libz.so.1|librustc_driver-*.so|libLLVM-*.so|libLLVM.so.*)
                ;;
            *) echo "unexpected dynamic dependency in $candidate: $library" >&2; exit 1 ;;
        esac
        echo "  NEEDED $library" >> "$details"
    done

    glibc_tokens=$(readelf --version-info "$candidate" 2>/dev/null | grep -o 'GLIBC_[A-Za-z0-9_.]*' | LC_ALL=C sort -u || true)
    for token in $glibc_tokens; do
        version=${token#GLIBC_}
        case "$version" in *[!0-9.]*|'') echo "non-numeric GLIBC requirement in $candidate: $token" >&2; exit 1;; esac
        version_le "$version" "$glibc_ceiling" || {
            echo "$candidate requires $token, newer than GLIBC_$glibc_ceiling" >&2
            exit 1
        }
        echo "  GLIBC $version" >> "$details"
    done

    gcc_tokens=$(readelf --version-info "$candidate" 2>/dev/null | grep -o 'GCC_[A-Za-z0-9_.]*' | LC_ALL=C sort -u || true)
    for token in $gcc_tokens; do
        version=${token#GCC_}
        case "$version" in *[!0-9.]*|'') echo "non-numeric GCC requirement in $candidate: $token" >&2; exit 1;; esac
        version_le "$version" "$gcc_ceiling" || {
            echo "$candidate requires $token, newer than GCC_$gcc_ceiling" >&2
            exit 1
        }
        echo "  GCC $version" >> "$details"
    done
done < "$elfs"

mkdir -p "$(dirname "$report")"
{
    echo "toolchain_root=$root"
    echo "glibc_ceiling=$glibc_ceiling"
    echo "gcc_ceiling=$gcc_ceiling"
    echo "elf_count=$(wc -l < "$elfs" | tr -d ' ')"
    cat "$details"
} > "$report"
