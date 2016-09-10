#!/usr/bin/env bash -eux

function main {
 	source /etc/lsb-release
  export DEBIAN_FRONTEND=noninteractive

  case "$DISTRIB_CODENAME" in
    trusty)
      add-apt-repository -y ppa:ubuntu-lxc/lxd-stable
      aptitude update
      ;;

  esac

  if lvs system/placeholder 1>/dev/null 2>&1; then
    lvremove -f system/placeholder 2>/dev/null >/dev/null || true
    lvcreate -n docker -l '50%FREE' system
    lvcreate -n lxd -l '100%FREE' system

    mkfs.ext4 /dev/system/docker

    mkfs.btrfs /dev/system/lxd
    mkdir -p /var/lib/lxd
    printf 'UUID=%s /var/lib/lxd btrfs user_subvol_rm_allowed\n' "$(blkid /dev/system/lxd | cut -d\" -f2)" >> /etc/fstab
  fi

  aptitude install -y lxd
	usermod -aG lxd ubuntu
}

main "$@"
