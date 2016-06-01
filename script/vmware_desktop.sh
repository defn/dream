#!/usr/bin/env bash -eux

set -eux

echo "==> Installing VMware Tools"

aptitude install -y open-vm-tools
mkdir -p /mnt/hgfs
