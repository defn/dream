#!/usr/bin/env bash

set -eux

umask 022

aptitude dist-upgrade -y
aptitude upgrade -y

reboot
sleep 120
