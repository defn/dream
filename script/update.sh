#!/usr/bin/env bash

set -eux
umask 022

systemctl disable apt-daily.service
systemctl disable apt-daily.timer

df -klh

if aptitude dist-upgrade -y; then
  if aptitude upgrade -y; then
    true
  fi
fi

df -klh
