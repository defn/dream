#!/usr/bin/env bash

set -exfu

while true; do 
  if [[ -f "/var/lib/cloud/instance/boot-finished" ]]; then break; fi
  find /var/lib/cloud/instance/ -ls
  sleep 3
done

export DEBIAN_FRONTEND=noninteractive 

dpkg --remove-architecture i386

apt-get update >/dev/null
apt-get install -y aptitude

aptitude update >/dev/null
if aptitude dist-upgrade -y; then
  if aptitude upgrade -y; then
    true
  fi
fi
