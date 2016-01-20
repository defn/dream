#!/bin/bash -eux

echo "==> Installing VirtualBox guest additions"

aptitude install -y linux-headers-$(uname -r) build-essential perl
aptitude install -y dkms

VBOX_VERSION=$(cat /home/${SSH_USERNAME}/.vbox_version)

if [[ -f "/home/${SSH_USERNAME}/VBoxGuestAdditions_$VBOX_VERSION.iso" ]]; then
  mount -o loop /home/${SSH_USERNAME}/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
  sh /mnt/VBoxLinuxAdditions.run
  umount /mnt
fi

rm -f /home/${SSH_USERNAME}/VBoxGuestAdditions_$VBOX_VERSION.iso
rm -f /home/${SSH_USERNAME}/.vbox_version
