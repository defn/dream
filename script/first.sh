#!/usr/bin/env bash

if [[ ! $PACKER_BUILDER_TYPE =~ amazon ]]; then
  if [[ -n "${http_proxy:-}" ]]; then
    {
      echo "Acquire::http::Proxy \"$http_proxy\";" 
      echo 'Acquire::Languages "none";'
    } | tee /etc/apt/apt.conf.d/99boxcache
  fi
fi

passwd -l ubuntu
passwd -l root

while true; do 
  if [[ -f "/var/lib/cloud/instance/boot-finished" ]]; then
    break
  fi
  find /var/lib/cloud/instance/ -ls
  sleep 3
done

dpkg --remove-architecture i386
apt-get update >/dev/null
apt-get install -y aptitude

aptitude update >/dev/null
aptitude install -y ntp curl unzip git perl ruby language-pack-en nfs-common build-essential dkms lvm2 xfsprogs xfsdump bridge-utils thin-provisioning-tools software-properties-common btrfs-tools ubuntu-fan
aptitude install -y linux-headers-$(uname -r)

export DEBIAN_FRONTEND=noninteractive 

locale

locale-gen en_US.UTF-8
dpkg-reconfigure locales
dpkg-reconfigure keyboard-configuration
localedef -i en_US -c -f UTF-8 en_US.UTF-8

locale
