#!/bin/bash -ux

umask 022

atrm 1

# install cloud-init last until TODO ssh breakage identified
if [[ $PACKER_BUILDER_TYPE =~ virtualbox ]]; then
  aptitude install -y cloud-init
fi

# make a docker image of our selves
mkdir /tmp/meh
mount -o bind / /mnt
mount -o bind /tmp/meh /mnt/tmp
mount -o bind /tmp/meh /mnt/var/lib/docker
pushd /mnt
mkdir tmp run/lock run/user
chmod 1777 tmp run/lock

tar -c . | docker import - ubuntu

popd

umount /mnt/tmp
umount /mnt/var/lib/docker
umount /mnt

sync
