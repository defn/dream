#!/bin/bash -ux

env | grep -i proxy
uname -a
if [[ ! $PACKER_BUILDER_TYPE =~ amazon ]]; then
  echo "Acquire::http::Proxy \"$http_proxy\";" | tee /etc/apt/apt.conf.d/99boxcache
fi
apt-get install -y aptitude
aptitude -y update > /dev/null
apt-get -y autoremove
