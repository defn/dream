#!/usr/bin/env bash

set -exfu

echo "==> Installing VirtualBox guest additions"

pth_vbox_version="$(set +f; ls -d /home/*/.vbox_version 2>/dev/null || true)"
if [[ ! -f "$pth_vbox_version" ]]; then
  exit 0
fi

cd "$(dirname "$pth_vbox_version")"
VBOX_VERSION=$(cat .vbox_version)

if [[ ! -f "VBoxGuestAdditions_$VBOX_VERSION.iso" ]]; then
  exit 0
fi

mount -o loop "$(pwd)/VBoxGuestAdditions_$VBOX_VERSION.iso" /mnt

# install
sh /mnt/VBoxLinuxAdditions.run || true
echo "==> Installed VirtualBox Guest Additions ${VBOX_VERSION}" 

umount /mnt
