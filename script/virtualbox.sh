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

install -d -o ubuntu -g ubuntu ~ubuntu/.ssh
touch ~ubuntu/.ssh/authorized_keys
chown ubuntu:ubuntu ~ubuntu/.ssh/authorized_keys
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key' >> ~ubuntu/.ssh/authorized_keys
