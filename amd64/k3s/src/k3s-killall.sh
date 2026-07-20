#!/bin/sh

[ "$(id -u)" -eq 0 ] || exec sudo --preserve-env=K3S_DATA_DIR "$0" "$@"

K3S_DATA_DIR=${K3S_DATA_DIR:-/var/lib/rancher/k3s}

for bin in "${K3S_DATA_DIR}"/data/*/bin/; do
    [ -d "$bin" ] && PATH=$PATH:$bin:$bin/aux
done
export PATH

if command -v systemctl >/dev/null 2>&1; then
    systemctl stop k3s.service k3s-agent.service >/dev/null 2>&1 || :
fi

pschildren() {
    ps -e -o ppid= -o pid= | sed -e 's/^\s*//g; s/\s\s*/\t/g;' | grep -w "^$1" | cut -f2
}

pstree() {
    for pid in "$@"; do
        echo "$pid"
        for child in $(pschildren "$pid"); do
            pstree "$child"
        done
    done
}

killtree() {
    pids=$(pstree "$@")
    [ -z "$pids" ] || kill -9 $pids >/dev/null 2>&1 || :
}

getshims() {
    ps -e -o pid= -o args= | sed -e 's/^ *//; s/\s\s*/\t/;' | grep -w "${K3S_DATA_DIR}"'/data/[^/]*/bin/containerd-shim' | cut -f1
}

shim_pids=$(getshims)
[ -z "$shim_pids" ] || killtree $shim_pids

do_unmount_and_remove() {
    while read -r _ path _; do
        case "$path" in
            "$1"*) echo "$path" ;;
        esac
    done < /proc/self/mounts | sort -r | xargs -r -n 1 sh -c 'umount -f "$0" && rm -rf "$0"'
}

do_unmount_and_remove '/run/k3s'
do_unmount_and_remove '/var/lib/kubelet/pods'
do_unmount_and_remove '/var/lib/kubelet/plugins'
do_unmount_and_remove '/run/netns/cni-'

if command -v ip >/dev/null 2>&1; then
    ip netns show 2>/dev/null | grep cni- | xargs -r -n 1 ip netns delete
    ip link show 2>/dev/null | grep 'master cni0' | while read -r _ iface _; do
        iface=${iface%%@*}
        iface=${iface%:}
        [ -z "$iface" ] || ip link delete "$iface" >/dev/null 2>&1 || :
    done
    for iface in cni0 flannel.1 flannel-v6.1 kube-ipvs0 flannel-wg flannel-wg-v6; do
        ip link delete "$iface" >/dev/null 2>&1 || :
    done
fi

rm -rf /var/lib/cni/

if command -v iptables-save >/dev/null 2>&1 && command -v iptables-restore >/dev/null 2>&1; then
    iptables-save | grep -v KUBE- | grep -v CNI- | grep -iv flannel | iptables-restore || :
fi
if command -v ip6tables-save >/dev/null 2>&1 && command -v ip6tables-restore >/dev/null 2>&1; then
    ip6tables-save | grep -v KUBE- | grep -v CNI- | grep -iv flannel | ip6tables-restore || :
fi

exit 0
