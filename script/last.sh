#!/bin/bash -ux

umask 022

# install cloud-init last until TODO ssh breakage identified
aptitude install -y cloud-init

sync
