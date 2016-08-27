#!/usr/bin/env bash

source /etc/lsb-release

aptitude -y purge nano mlocate

aptitude install -y software-properties-common

case "$DISTRIB_CODENAME" in
  trusty)
    add-apt-repository ppa:ubuntu-lxc/lxd-stable
    apt-add-repository -y ppa:zfs-native/stable
    aptitude update
    aptitude install -y ubuntu-zfs dkms
    ;;

  xenial)
    aptitude install -y zfsutils-linux
    true
    ;;
esac

aptitude install -y lxd

cat >/etc/default/lxd-bridge- <<EOF
USE_LXD_BRIDGE="true"
LXD_BRIDGE="lxdbr0"
UPDATE_PROFILE="true"
LXD_CONFILE=""
LXD_DOMAIN="lxd"
LXD_IPV4_ADDR="10.79.163.1"
LXD_IPV4_NETMASK="255.255.255.0"
LXD_IPV4_NETWORK="10.79.163.1/24"
LXD_IPV4_DHCP_RANGE="10.79.163.2,10.79.163.254"
LXD_IPV4_DHCP_MAX="252"
LXD_IPV4_NAT="true"
LXD_IPV6_ADDR=""
LXD_IPV6_MASK=""
LXD_IPV6_NETWORK=""
LXD_IPV6_NAT="false"
LXD_IPV6_PROXY="false"
EOF

cat >/etc/default/lxd-bridge <<EOF
source /etc/default/lxd-bridge-
EOF

service lxc restart

modprobe zfs || true
if !zpool list lxd; then
  zpool create lxd /dev/mapper/system-lxd--data
  lxc config set storage.zfs_pool_name lxd

  cd ~root
  lxc image copy ubuntu-daily:16.04 local: --alias xenial
  lxc image copy ubuntu-daily:14.04 local: --alias trusty
  rm -rf ~ubuntu/.config/lxc
fi

lxc image list

zpool list

ifconfig -a
