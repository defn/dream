#!/usr/bin/env bash -eux

set -eux

echo "==> Installing VMware Tools"

aptitude install -y open-vm-tools open-vm-tools-desktop 
mkdir -p /mnt/hgfs
