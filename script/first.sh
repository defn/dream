#!/usr/bin/env bash -ux

if [[ ! $PACKER_BUILDER_TYPE =~ amazon ]]; then
  if [[ -n "${http_proxy:-}" ]]; then
    echo "Acquire::http::Proxy \"$http_proxy\";" | tee /etc/apt/apt.conf.d/99boxcache
  fi
fi


useradd -s /bin/bash -m ubuntu || true
chsh -s /bin/bash ubuntu
gpasswd -a ubuntu sudo

cat > /etc/sudoers.d/90-cloud-init-users <<EOF
# User rules for ubuntu
ubuntu ALL=(ALL) NOPASSWD:ALL
EOF
chmod 440 /etc/sudoers.d/90-cloud-init-users

apt-get update
apt-get install -y aptitude

aptitude update
aptitude hold -y libpcre3

aptitude install -y ntp curl unzip git perl ruby language-pack-en nfs-common build-essential dkms lvm2 linux-headers-$(uname -r)
update-locale LANG=en_US.UTF-8

install -d -o ubuntu -g ubuntu /opt/pkgsrc /vagrant
