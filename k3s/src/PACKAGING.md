# K3s package notes

Pigsty package `k3s 1.36.4-1PGSTY` contains the upstream
`v1.36.4+k3s1` binary. The upstream K3s revision is recorded explicitly in
the package description and build recipe; `1PGSTY` identifies this Pigsty
packaging revision.

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

Removing the package stops both unit variants and removes their package-owned
systemd enablement. It does not run `k3s-killall.sh` automatically. The script
is installed as `/usr/bin/k3s-killall.sh` for an administrator to invoke when
process, mount, and transient CNI cleanup is desired. Package removal preserves
`/etc/rancher/k3s` and `/var/lib/rancher/k3s`.
