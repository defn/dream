#!/usr/bin/env bash -eux

aptitude install -y openssh-server

install -d -o root -g root -m 0755  /var/run/sshd

if [[ -f "/etc/ssh/sshd_config" ]]; then
  {
    echo
    echo "UseDNS no"
    echo "MaxAuthTries 20"
  } >> /etc/ssh/sshd_config
fi
