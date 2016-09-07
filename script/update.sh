#!/usr/bin/env bash

set -eux
umask 022

aptitude dist-upgrade -y
aptitude upgrade -y

if [[ $PACKER_BUILDER_TYPE =~ iso ]]; then
	aptitude install -y linux-generic-lts-xenial
	reboot
	sleep 120
fi
