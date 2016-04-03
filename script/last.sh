#!/usr/bin/env bash -ux

umask 022

passwd -l ubuntu

aptitude -y update > /dev/null

# install cloud-init last until TODO ssh breakage identified
aptitude install -y cloud-init

# upgrade all packages
aptitude -y upgrade

rm -f /etc/apt/apt.conf.d/99boxcache

sync
