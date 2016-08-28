#!/usr/bin/env bash

set -eux
umask 022

aptitude dist-upgrade -y
aptitude upgrade -y

if [[ ! $PACKER_BUILDER_TYPE =~ docker ]]; then
	aptitude install -y linux-generic-lts-xenial
fi

if [[ ! $PACKER_BUILDER_TYPE =~ docker ]]; then
	reboot
	sleep 120
fi
