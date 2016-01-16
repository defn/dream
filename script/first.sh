#!/bin/bash -ux

uname -a
sudo apt-get -y autoremove
sudo apt-get -y update
sudo apt-get install -y aptitude
