#!/usr/bin/env bash -ux

umask 022

passwd -l ubuntu

# install cloud-init last until TODO ssh breakage identified
aptitude install -y cloud-init

rm -f /etc/apt/apt.conf.d/99boxcache

sync

cat ~ubuntu/.ssh/authorized_keys 2>&- || true

chown -v -R ubuntu:ubuntu ~ubuntu/.config 2>&- || true
