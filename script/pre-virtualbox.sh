#!/usr/bin/env bash -ux

umask 022

aptitude -y update > /dev/null

# upgrade everything except libpcre3
aptitude hold libcre3
aptitude -y upgrade

sync

reboot
