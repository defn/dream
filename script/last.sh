#!/bin/bash -ux

umask 022

passwd -l ubuntu

# install cloud-init last until TODO ssh breakage identified
aptitude install -y cloud-init

aptitude -y update
aptitude -y dist-upgrade --force-yes
aptitude -y upgrade

sync
