#!/usr/bin/env bash

source /etc/lsb-release

aptitude -y install unzip curl lvm2 ruby git lxd
aptitude -y purge nano mlocate

case "$DISTRIB_CODENAME" in
  trusty)
    apt-add-repository -y ppa:zfs-native/stable
    aptitude update
    aptitude install -y ubuntu-zfs
    ;;

  xenial)
    aptitude install -y zfsutils-linux
    ;;
esac
