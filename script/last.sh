#!/usr/bin/env bash -ux

umask 022

passwd -l ubuntu

rm -f /etc/apt/apt.conf.d/99boxcache

sync

cat ~ubuntu/.ssh/authorized_keys 2>&- || true
