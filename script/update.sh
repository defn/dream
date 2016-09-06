#!/usr/bin/env bash

set -eux
umask 022

aptitude dist-upgrade -y
aptitude upgrade -y

aptitude install -y cloud-init

mkdir -p /var/lib/cloud/seed/nocloud
touch /var/lib/cloud/seed/nocloud/meta-data

cat <<EOF | tee /var/lib/cloud/seed/nocloud/user-data
From nobody Wed Aug 10 18:58:26 2016
Content-Type: multipart/mixed; boundary="===============88888888888888888888888888=="
MIME-Version: 1.0
Number-Attachments: 1

--===============88888888888888888888888888==
MIME-Version: 1.0
Content-Type: text/cloud-config
Content-Disposition: attachment; filename="part-001"

users:
  - name: ubuntu
    shell: /bin/bash
    sudo: "ALL=(ALL) NOPASSWD: ALL"

--===============88888888888888888888888888==
EOF

cat <<EOF | tee /etc/cloud/cloud.cfg.d/no-ec2.cfg
datasource:
  NoCloud
datasource_list: [ NoCloud ]
disable_ec2_metadata: True
EOF

touch ~root/.cloud-init.hostname

if [[ $PACKER_BUILDER_TYPE =~ iso ]]; then
	aptitude install -y linux-generic-lts-xenial
	reboot
	sleep 120
fi
