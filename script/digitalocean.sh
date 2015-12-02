#!/bin/bash -eux

if [[ $PACKER_BUILDER_TYPE =~ digitalocean ]]; then
  true
fi
