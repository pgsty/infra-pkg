#!/bin/bash
set -euo pipefail

#==============================================================#
# File      :   download.sh
# Ctime     :   2021-04-21
# Mtime     :   2022-03-19
# Desc      :   Download Loki Stuff from Github
# Path      :   loki/download
# Depend    :   curl unzip
# Copyright (C) 2018-2022 Ruohang Feng
#==============================================================#

#==============================================================#
# color log util
#==============================================================#
__CN='\033[0m'    # no color
__CB='\033[0;30m' # black
__CR='\033[0;31m' # red
__CG='\033[0;32m' # green
__CY='\033[0;33m' # yellow
__CB='\033[0;34m' # blue
__CM='\033[0;35m' # magenta
__CC='\033[0;36m' # cyan
__CW='\033[0;37m' # white
function log_info() {  printf "[${__CG} OK ${__CN}] ${__CG}$*${__CN}\n";   }
function log_warn() {  printf "[${__CY}WARN${__CN}] ${__CY}$*${__CN}\n";   }
function log_error() { printf "[${__CR}FAIL${__CN}] ${__CR}$*${__CN}\n";   }
function log_debug() { printf "[${__CB}HINT${__CN}] ${__CB}$*${__CN}\n"; }
function log_input() { printf "[${__CM} IN ${__CN}] ${__CM}$*\n=> ${__CN}"; }
function log_hint()  { printf "${__CB}$*${__CN}\n"; }
#==============================================================#


#==============================================================#
# download loki
#==============================================================#
function get_loki() {
    local tmpdir=/tmp
    local version=latest
    local path=${tmpdir}
    local remove=no

    # parse arguments
    while [ $# -gt 0 ]; do
        case $1 in
        -h|--help)
			cat <<-'EOF'
			NAME
			    get_loki  -- download loki, promtail, loki-canary logcli from internet
			SYNOPSIS
			    download loki from github release page
			    get_loki           [-v|--version=latest]     # loki version (latest by default)
			                       [-p|--path=/tmp/]         # where DIR path to put loki binary(s)
			                       [-t|--tmpdir=/tmp]        # where to put tmp resource (or use cache)
			                       [-r|--remove]             # force re-download and remove tarball
			                       [-h|--help]               # print this message
			EXAMPLES
			    get_loki                  # get latest loki binary to /tmp/loki
			    get_loki  -v 3.1.0        # get specific version of loki (3.1.0)
			    get_loki  -p /usr/bin     # download binaries to specific path `/usr/bin`
			    get_loki  -r              # force re-download and remove tarball after download
			EOF
            exit 0;;
        -v|--version) version="$2" ; shift;;
        -p|--path) path="$2" ; shift;;
        -t|--tmpdir) tmpdir="$2" ; shift;;
        -r|--remove) remove="yes" ;;
        (--) shift; break;;
        (-*) log_error "$0: error - unrecognized option $1" 1>&2; exit 1;;
        (*) break;;
        esac
        shift
    done

    # translate latest version into specific version with github API
    if [[ ${version} == "latest" ]]; then
        log_info "get latest version of loki"
        version=$(curl --silent "https://api.github.com/repos/grafana/loki/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
        if [[ ${version} =~ ^[0-9]+\.[0-9]+\.[0-9]+ ]]; then
            log_info "latest version of loki is v${version}"
        else
            log_error "fail to get latest loki version from github: $version"
            exit 1
        fi
    fi

    ###################
    # loki
    ##################
    local filename="loki-linux-amd64"
    local tarball="${filename}.zip"
    local url="https://github.com/grafana/loki/releases/download/v${version}/${tarball}"

    if [[ ! -f ${tmpdir}/${tarball} || ${remove} == "yes" ]] ; then
        log_info "download loki from ${url} to ${tmpdir}"
        curl -L ${url} -o ${tmpdir}/${tarball}
    else
        log_hint "found loki on ${tmpdir}, move to ${path}/loki"
    fi

    cd ${tmpdir} > /dev/null
    rm -rf ${filename} && unzip -qq ${tarball} > /dev/null 2>&1 && mv -f ${filename} ${path}/loki
    cd - > /dev/null
    [ ${remove} == "yes" ] && rm -rf ${tmpdir:?}/${tarball:?}    # remove tarball if -r|--remove specified


    ###################
    # promtail
    ##################
    local filename="promtail-linux-amd64"
    local tarball="${filename}.zip"
    local url="https://github.com/grafana/loki/releases/download/v${version}/${tarball}"
    if [[ ! -f ${tmpdir}/${tarball} || ${remove} == "yes" ]] ; then
        log_info "download promtail from ${url} to ${tmpdir}"
        curl -L ${url} -o ${tmpdir}/${tarball}
    else
        log_hint "found promtail on ${tmpdir}, move to ${path}/loki"
    fi
    cd ${tmpdir} > /dev/null
    rm -rf ${filename} && unzip -qq ${tarball} && mv -f ${filename} ${path}/promtail
    cd - > /dev/null
    [ ${remove} == "yes" ] && rm -rf ${tmpdir:?}/${tarball:?}    # remove tarball if -r|--remove specified


    ###################
    # logcli
    ##################
    local filename="logcli-linux-amd64"
    local tarball="${filename}.zip"
    local url="https://github.com/grafana/loki/releases/download/v${version}/${tarball}"

    if [[ ! -f ${tmpdir}/${tarball} || ${remove} == "yes" ]] ; then
        log_info "download logcli from ${url} to ${tmpdir}"
        curl -L ${url} -o ${tmpdir}/${tarball}
    else
        log_hint "found logcli on ${tmpdir}, move to ${path}/loki"
    fi

    cd ${tmpdir} > /dev/null
    rm -rf ${filename} && unzip -qq ${tarball} && mv -f ${filename} ${path}/logcli
    cd - > /dev/null
    [ ${remove} == "yes" ] && rm -rf ${tmpdir:?}/${tarball:?}    # remove tarball if -r|--remove specified

    ###################
    # loki-canary
    ##################
    local filename="loki-canary-linux-amd64"
    local tarball="${filename}.zip"
    local url="https://github.com/grafana/loki/releases/download/v${version}/${tarball}"

    if [[ ! -f ${tmpdir}/${tarball} || ${remove} == "yes" ]] ; then
        log_info "download loki-canary from ${url} to ${tmpdir}"
        curl -L ${url} -o ${tmpdir}/${tarball}
    else
        log_hint "found loki-canary on ${tmpdir}, move to ${path}/loki"
    fi

    cd ${tmpdir} > /dev/null
    rm -rf ${filename} && unzip -qq ${tarball} && mv -f ${filename} ${path}/loki-canary
    cd - > /dev/null
    [ ${remove} == "yes" ] && rm -rf ${tmpdir:?}/${tarball:?}    # remove tarball if -r|--remove specified

    log_info "loki @ ${path}"
}

get_loki $@
