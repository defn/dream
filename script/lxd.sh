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

cd ~root
lxc image copy ubuntu-daily:16.04 local: --alias xenial
lxc image copy ubuntu-daily:14.04 local: --alias trusty
rm -rf ~ubuntu/.config/lxc
