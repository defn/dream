#!/usr/bin/env bash -ux

umask 022

passwd -l ubuntu
passwd -l root

rm -f /var/lib/cloud/seed/nocloud/user-data
rm -f /var/lib/cloud/seed/nocloud/meta-data
rm -f /etc/cloud/cloud.cfg.d/no-ec2.cfg

chown -R ubuntu:ubuntu ~ubuntu

sync
