#!/usr/bin/env bash -ux

if [[ ! $PACKER_BUILDER_TYPE =~ amazon ]]; then
  if [[ -n "${http_proxy:-}" ]]; then
    echo "Acquire::http::Proxy \"$http_proxy\";" | tee /etc/apt/apt.conf.d/99boxcache
  fi
fi
apt-get install -y aptitude
aptitude hold -y libpcre3
apt-get install -y software-properties-common
add-apt-repository ppa:ubuntu-lxc/lxd-stable
aptitude -y update > /dev/null
