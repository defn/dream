#!/usr/bin/env bash -eux

function main {
 	source /etc/lsb-release
  export DEBIAN_FRONTEND=noninteractive

  set -exfu

  add-apt-repository ppa:ubuntu-lxc/lxd-stable
  aptitude update
  aptitude install -y lxd

	usermod -aG lxd ubuntu

  mkfs.btrfs /dev/inception/lxd
  mkdir -p /var/lib/lxd
  printf 'UUID=%s /var/lib/lxd btrfs user_subvol_rm_allowed\n' "$(blkid /dev/inception/lxd | cut -d\" -f2)" >> /etc/fstab
}

main "$@"
