# K3s package notes

Pigsty package `k3s 1.36.2-1` contains the upstream `v1.36.2+k3s1` binary.
The package release maps the upstream K3s revision: an upstream `+k3s2`
rebuild would become package release `2`. If the packaging itself needs a
rebuild without an upstream revision change, use a subordinate release such
as `1.1`, which still sorts before upstream revision release `2`.

Installing or upgrading this package does not enable, start, or restart K3s.
Configure the node through `/etc/rancher/k3s/config.yaml` and its drop-in
directory, then explicitly enable either `k3s.service` for a server or
`k3s-agent.service` for an agent.

The package does not create generic `kubectl`, `crictl`, or `ctr` symlinks.
Use the `k3s kubectl`, `k3s crictl`, and `k3s ctr` subcommands, or manage
those symlinks separately.

On RPM systems with SELinux enforcing, install a compatible K3s SELinux
policy package before starting the service. The policy is maintained and
released separately by upstream and is not embedded in this package.

Removing the package stops both unit variants and runs `k3s-killall.sh` to
clean up K3s processes, mounts, and transient CNI state. It deliberately
preserves `/etc/rancher/k3s` and `/var/lib/rancher/k3s`.
