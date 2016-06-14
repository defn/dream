#!/usr/bin/env bash -ux

umask 022

#passwd -l ubuntu

# install cloud-init last until TODO ssh breakage identified
aptitude install -y cloud-init

rm -f /etc/apt/apt.conf.d/99boxcache

sync
