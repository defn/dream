#!/bin/bash -ux

useradd -s /bin/bash -m ubuntu || true
chsh -s /bin/bash ubuntu
gpasswd -a ubuntu sudo
echo 'ubuntu ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/ubuntu
rm -vf ~ubuntu/.ssh/authorized_keys
