#!/usr/bin/env bash

function main {
  set -exfu

  if mkfs.btrfs /dev/inception/lxd; then
    mkdir -p /var/lib/lxd
    printf 'UUID=%s /var/lib/lxd btrfs user_subvol_rm_allowed\n' "$(blkid /dev/inception/lxd | cut -d\" -f2)" >> /etc/fstab
  fi

  cat <<EOF | tee /etc/sysctl.d/99-lxd.conf
fs.inotify.max_queued_events = 1048576
fs.inotify.max_user_instances = 1048576
fs.inotify.max_user_watches = 1048576
vm.max_map_count = 262144
net.core.netdev_max_backlog = 182757
EOF

  cat <<EOF | tee /etc/security/limits.d/99-lxd.conf
* soft nofile 1048576
* hard nofile 1048576
root soft nofile 1048576
root hard nofile 1048576
* soft memlock unlimited
* hard memlock unlimited
EOF
}

main "$@"
