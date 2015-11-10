#!/bin/bash -ux

useradd -s /bin/bash -m ubuntu || true
chsh -s /bin/bash ubuntu
passwd -l ubuntu
gpasswd -a ubuntu docker
gpasswd -a ubuntu sudo
echo 'ubuntu ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/ubuntu
date > ~ubuntu/.created

if [[ ! $PACKER_BUILDER_TYPE =~ virtualbox|parallels|vmware ]]; then
  rm -vf ~ubuntu/.ssh/authorized_keys
fi

find /home/ubuntu | xargs ls -ltrhd
