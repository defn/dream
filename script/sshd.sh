#!/usr/bin/env bash -eux

if [[ -f "/etc/ssh/sshd_config" ]]; then
  {
    echo
    echo "UseDNS no"
    echo "MaxAuthTries 20"
  } >> /etc/ssh/sshd_config
fi
