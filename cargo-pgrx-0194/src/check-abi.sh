#!/bin/sh
set -eu

binary=${1:?binary is required}
glibc_ceiling=${2:?GLIBC ceiling is required}
gcc_ceiling=${3:?GCC ceiling is required}
report=${4:?report path is required}

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

needed=$(readelf -d "$binary" | sed -n 's/.*Shared library: \[\(.*\)\].*/\1/p')
for library in $needed; do
    case "$library" in
        ld-linux-aarch64.so.1|ld-linux-x86-64.so.2|libc.so.6|libdl.so.2|libgcc_s.so.1|libm.so.6|libpthread.so.0|librt.so.1) ;;
        *) echo "unexpected cargo-pgrx dependency: $library" >&2; exit 1 ;;
    esac
done

glibc_tokens=$(readelf --version-info "$binary" | grep -o 'GLIBC_[A-Za-z0-9_.]*' | LC_ALL=C sort -u || true)
glibc_versions=
for token in $glibc_tokens; do
    version=${token#GLIBC_}
    case "$version" in *[!0-9.]*|'') echo "non-numeric cargo-pgrx GLIBC requirement: $token" >&2; exit 1;; esac
    version_le "$version" "$glibc_ceiling" || {
        echo "cargo-pgrx requires GLIBC_$version, newer than GLIBC_$glibc_ceiling" >&2
        exit 1
    }
    glibc_versions="$glibc_versions $version"
done

gcc_tokens=$(readelf --version-info "$binary" | grep -o 'GCC_[A-Za-z0-9_.]*' | LC_ALL=C sort -u || true)
gcc_versions=
for token in $gcc_tokens; do
    version=${token#GCC_}
    case "$version" in *[!0-9.]*|'') echo "non-numeric cargo-pgrx GCC requirement: $token" >&2; exit 1;; esac
    version_le "$version" "$gcc_ceiling" || {
        echo "cargo-pgrx requires GCC_$version, newer than GCC_$gcc_ceiling" >&2
        exit 1
    }
    gcc_versions="$gcc_versions $version"
done

mkdir -p "$(dirname "$report")"
{
    echo "binary=$binary"
    echo "glibc_ceiling=$glibc_ceiling"
    echo "gcc_ceiling=$gcc_ceiling"
    for library in $needed; do echo "needed=$library"; done
    for version in $glibc_versions; do echo "glibc=$version"; done
    for version in $gcc_versions; do echo "gcc=$version"; done
    readelf -A "$binary" 2>/dev/null || true
} > "$report"
