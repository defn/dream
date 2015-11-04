#!/bin/bash -ux

useradd -s /bin/bash -m ubuntu || true
chsh -s /bin/bash ubuntu
passwd -l ubuntu
gpasswd -a ubuntu docker
gpasswd -a ubuntu sudo
rm -f ~ubuntu/.ssh/authorized_keys
echo 'ubuntu ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/ubuntu
