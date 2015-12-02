#!/bin/bash -eux

if [[ $PACKER_BUILDER_TYPE =~ docker ]]; then
  # TODO stupid slow in a container
  # apt-get install -y minimal^ server^ standard^

  install -d -m 0700 -o ubuntu -g ubuntu ~ubuntu/.ssh 
  echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key' > ~ubuntu/.ssh/authorized_keys
  chown ubuntu:ubuntu ~ubuntu/.ssh/authorized_keys
  chmod 0600 ~ubuntu/.ssh/authorized_keys

  install -d -m 0700 -o root -g root ~root/.ssh 
  install -m 0600 -o root -g root ~ubuntu/.ssh/authorized_keys ~root/.ssh/authorized_keys
fi
