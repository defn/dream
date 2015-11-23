#!/bin/bash -ux

umask 022

# install cloud-init last until TODO ssh breakage identified
aptitude install -y cloud-init

if [[ ! $PACKER_BUILDER_TYPE =~ docker ]]; then
  # make a docker image of our selves
  mount -o bind / /mnt

  mkdir -p /tmp/meh/{tmp,docker}
  mount -o bind /tmp/meh/tmp /mnt/tmp
  mount -o bind /tmp/meh/docker /mnt/var/lib/docker

  pushd /mnt
  mkdir run/lock run/user
  chmod 1777 tmp run/lock

  tar -c . | docker import - ubuntu

  popd

  umount /mnt/tmp
  umount /mnt/var/lib/docker
  umount /mnt
fi

sync

