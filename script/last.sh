#!/bin/bash -ux

atrm 1

if [[ $PACKER_BUILDER_TYPE =~ virtualbox ]]; then
  aptitude install -y cloud-init
fi
