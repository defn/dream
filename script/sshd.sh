#!/bin/bash -eux

apt-get install -y openssh-server

install -d -o root -g root -m 0755  /var/run/sshd

if [[ -f "/etc/ssh/sshd_config" ]]; then
  echo "UseDNS no" >> /etc/ssh/sshd_config
fi
