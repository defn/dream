#!/usr/bin/env bash -eux

set -eux

echo "==> Installing Parallels tools"

aptitude install -y linux-headers-$(uname -r) build-essential perl
aptitude install -y dkms

pth_parallels_iso="$(ls -d /home/*/prl-tools-lin.iso 2>/dev/null || true)"
if [[ -f "$pth_parallels_iso" ]]; then
  cd "$(dirname "$pth_parallels_iso")"

  if [[ -f "prl-tools-lin.iso" ]]; then
    mount -o loop "$(pwd)/prl-tools-lin.iso" /mnt

    # install
		/mnt/install --install-unattended-with-deps

    umount /mnt
  fi
fi
