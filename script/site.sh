#!/usr/bin/env bash

source /etc/lsb-release

aptitude -y purge nano mlocate

aptitude install -y software-properties-common

case "$DISTRIB_CODENAME" in
  trusty)
    add-apt-repository ppa:ubuntu-lxc/lxd-stable
    apt-add-repository -y ppa:zfs-native/stable
    aptitude update
    aptitude install -y lxd ubuntu-zfs dkms
    ;;

  xenial)
    aptitude install -y lxd zfsutils-linux
    ;;
esac
