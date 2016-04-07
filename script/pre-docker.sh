#!/usr/bin/env bash

set -eux

umask 022

aptitude hold -y grub-pc
aptitude dist-upgrade -y
aptitude upgrade -y
