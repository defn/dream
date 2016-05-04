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

    # install
    sh /mnt/VBoxLinuxAdditions.run || true
    echo "==> Installed VirtualBox Guest Additions ${VBOX_VERSION}" 

    umount /mnt
  fi

  rm -f VBoxGuestAdditions*iso
  rm -f .vbox_version
fi
