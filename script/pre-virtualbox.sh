#!/usr/bin/env bash

set -eux

umask 022

aptitude install -y linux-generic-lts-xenial
aptitude dist-upgrade -y
aptitude upgrade -y

sync

if [[ -f /var/run/reboot-required ]]; then
  reboot
  sleep 120
fi
