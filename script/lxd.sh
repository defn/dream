#!/usr/bin/env bash

source /etc/lsb-release

case "$DISTRIB_CODENAME" in
  xenial)
    aptitude install -y zfsutils-linux lxd
    true
    ;;
esac
