#!/bin/bash -ux

useradd -s /bin/bash -m ubuntu || true
chsh -s /bin/bash ubuntu
passwd -l ubuntu
gpasswd -a ubuntu docker
gpasswd -a ubuntu sudo
echo 'ubuntu ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/ubuntu
date > ~ubuntu/.created

rm -vf ~ubuntu/.ssh/authorized_keys

find /home/ubuntu | xargs ls -ltrhd
