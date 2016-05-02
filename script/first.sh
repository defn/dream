#!/usr/bin/env bash -ux

if [[ ! $PACKER_BUILDER_TYPE =~ amazon ]]; then
  if [[ -n "${http_proxy:-}" ]]; then
    echo "Acquire::http::Proxy \"$http_proxy\";" | tee /etc/apt/apt.conf.d/99boxcache
  fi
fi

apt-get update > /dev/null

apt-get install -y aptitude

aptitude hold -y libpcre3

aptitude install -y ntp curl unzip git perl ruby language-pack-en nfs-common build-essential dkms lvm2 linux-headers-$(uname -r)
update-locale LANG=en_US.UTF-8

install -d -o ubuntu -g ubuntu /opt/pkgsrc /vagrant
