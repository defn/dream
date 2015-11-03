#!/bin/bash -eux

SSH_USER=${SSH_USERNAME:-vagrant}

if [[ $PACKER_BUILDER_TYPE =~ digitalocean ]]; then
  true
fi
