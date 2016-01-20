#!/bin/bash -eux

aptitude install -y openssh-server

install -d -o root -g root -m 0755  /var/run/sshd

if [[ -f "/etc/ssh/sshd_config" ]]; then
  echo "UseDNS no" >> /etc/ssh/sshd_config
  echo "MaxAuthTries 20" >> /etc/ssh/sshd_config
fi
