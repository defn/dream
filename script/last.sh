#!/usr/bin/env bash -ux

umask 022

passwd -l ubuntu
passwd -l root

aptitude -y purge nano mlocate ubuntu-release-upgrader-core

cat ~ubuntu/.ssh/authorized_keys 2>/dev/null || true

chown -R ubuntu:ubuntu ~ubuntu

sync
