#!/usr/bin/env bash

source /etc/lsb-release

aptitude -y purge nano mlocate

aptitude install -y software-properties-common

case "$DISTRIB_CODENAME" in
  trusty)
    add-apt-repository ppa:ubuntu-lxc/lxd-stable
    aptitude update
    ;;

  xenial)
    aptitude install -y zfsutils-linux
    true
    ;;
esac

aptitude install -y lxd

lxc launch ubuntu-daily:16.04 docker -p default -p docker
lxc exec docker -- apt update
lxc exec docker -- apt dist-upgrade -y
lxc exec docker -- apt install docker.io -y
