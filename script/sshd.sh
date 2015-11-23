#!/bin/bash -eux

if [[ -f "/etc/ssh/sshd_config" ]]; then
  echo "UseDNS no" >> /etc/ssh/sshd_config
fi
