#!/usr/bin/env bash

if [[ ! $PACKER_BUILDER_TYPE =~ amazon ]]; then
  if [[ -n "${http_proxy:-}" ]]; then
    echo "Acquire::http::Proxy \"$http_proxy\";" | tee /etc/apt/apt.conf.d/99boxcache
  fi
fi

apt-get update >/dev/null
apt-get install -y aptitude

aptitude update >/dev/null
#aptitude hold -y libpcre3

aptitude install -y ntp curl unzip git perl ruby language-pack-en nfs-common build-essential dkms lvm2 xfsprogs xfsdump bridge-utils linux-headers-$(uname -r)
update-locale LANG=en_US.UTF-8

useradd -s /bin/bash -m ubuntu || true
chsh -s /bin/bash ubuntu
gpasswd -a ubuntu sudo

cat > /etc/sudoers.d/90-cloud-init-users <<EOF
# User rules for ubuntu
ubuntu ALL=(ALL) NOPASSWD:ALL
EOF
chmod 440 /etc/sudoers.d/90-cloud-init-users

install -d -o ubuntu -g ubuntu /opt/pkgsrc /vagrant
