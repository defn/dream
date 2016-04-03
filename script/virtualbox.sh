#!/usr/bin/env bash -eux

set -eux

echo "==> Installing VirtualBox guest additions"

aptitude install -y linux-headers-$(uname -r) build-essential perl
aptitude install -y dkms

pth_vbox_version="$(ls -d /home/*/.vbox_version 2>/dev/null || true)"
if [[ -f "$pth_vbox_version" ]]; then
  cd "$(dirname "$pth_vbox_version")"
  VBOX_VERSION=$(cat .vbox_version)

  if [[ -f "VBoxGuestAdditions_$VBOX_VERSION.iso" ]]; then
    mount -o loop "$(pwd)/VBoxGuestAdditions_$VBOX_VERSION.iso" /mnt
    sh /mnt/VBoxLinuxAdditions.run || true
    umount /mnt
  fi

  rm -f VBoxGuestAdditions*iso
  rm -f .vbox_version
fi
