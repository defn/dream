#!/usr/bin/env bash -eux

function main {
 	source /etc/lsb-release
  export DEBIAN_FRONTEND=noninteractive

  local use_btrfs=
  if lvs system/thinpool-data 1>/dev/null 2>&1; then
    lvremove -f system/thinpool-data 2>/dev/null >/dev/null || true

    if [[ -n "$use_btrfs" ]]; then
      apt-get install -y btrfs-tools
      lvcreate -n btrfs -L 30G system
      mkfs.btrfs /dev/system/btrfs
      mkdir /var/lib/lxd
      mount -o user_subvol_rm_allowed /dev/system/btrfs /var/lib/lxd
    fi
  fi

  case "$DISTRIB_CODENAME" in
    trusty)
      add-apt-repository -y ppa:ubuntu-lxc/lxd-stable
      aptitude update
      ;;

  esac

  aptitude install -y lxd

	lxc config set storage.lvm_vg_name system

	usermod -aG lxd ubuntu
}

main "$@"
