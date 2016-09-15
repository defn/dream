#!/usr/bin/env bash -eux

function main {
 	source /etc/lsb-release
  export DEBIAN_FRONTEND=noninteractive

  set -exfu

  add-apt-repository ppa:ubuntu-lxc/lxd-stable
  aptitude update

  if ! lvs inception/lxd 1>/dev/null 2>&1; then
    lvreduce -f -L 1M inception/placeholder
    lvcreate -l '50%FREE' -n lxd inception
    lvcreate -T -l '50%FREE' inception/docker
    lvs

    mkfs.btrfs /dev/inception/lxd
    mkdir -p /var/lib/lxd
    printf 'UUID=%s /var/lib/lxd btrfs user_subvol_rm_allowed\n' "$(blkid /dev/inception/lxd | cut -d\" -f2)" >> /etc/fstab
  fi

  aptitude install -y lxd
	usermod -aG lxd ubuntu
}

main "$@"
