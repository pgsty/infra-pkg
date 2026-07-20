# K3s air-gap image package notes

This package contains the upstream `v1.36.2+k3s1` system image archive for
amd64 nodes. It is installed without extraction at:

`/var/lib/rancher/k3s/agent/images/k3s-airgap-images-amd64.tar.zst`

The package does not import images or restart K3s. K3s imports the archive on
its next start. Conditional image imports can be enabled separately by
creating `.cache.json` in the image directory.

`k3s-images 1.36.2-1` has an exact dependency on `k3s 1.36.2-1`, so
the binary and bootstrap image set cannot be mixed across package revisions.

This archive contains the K3s bootstrap system images only. Additional CNI,
CSI, monitoring, application, and system-upgrade-controller images are not
included.
