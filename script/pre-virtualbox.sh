#!/usr/bin/env bash -ux

umask 022

aptitude install -y linux-generic-lts-xenial
aptitude dist-upgrade -y
aptitude upgrade -y

sync

reboot
sleep 60
