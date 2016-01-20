#!/bin/bash -ux

env | grep -i proxy
uname -a
sudo apt-get -y autoremove
sudo apt-get install -y aptitude
sudo aptitude -y update
