#!/bin/bash

give_docker_non_root_access() {
    # Add the docker group if it doesn't already exist
    groupadd docker
}

docker_package_install() {
    # Get the latest docker package
    curl -sSL https://get.docker.com/gpg | sudo apt-key add -

    # Install Docker
    curl -sSL https://get.docker.com/ | sh

    # listen on tcp, use device mapper
    cat | sudo tee -a /etc/default/docker <<"____EOF"
DOCKER_OPTS="-H tcp://0.0.0.0: --storage-driver=devicemapper"
____EOF

    # Enable memory and swap accounting
    sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/' /etc/default/grub
    update-grub
}

aptitude -y install git vim unzip curl language-pack-en
aptitude -y purge nano mlocate

if [[ ! $PACKER_BUILDER_TYPE =~ docker ]]; then
  if [[ ! -x "$(which docker 2>&- || true)" ]]; then
    give_docker_non_root_access
    docker_package_install 
  fi
fi
