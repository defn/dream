#!/bin/bash -ux

sudo aptitude update
sudo aptitude install -y at
echo sudo poweroff | at now +55 minutes
