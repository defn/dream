#!/bin/bash -eux

if [[ $PACKER_BUILDER_TYPE =~ aws ]]; then
  true
fi
