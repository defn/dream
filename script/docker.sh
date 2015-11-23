#!/bin/bash -eux

SSH_USER=${SSH_USERNAME:-vagrant}
SSH_PASS=${SSH_PASSWORD:-vagrant}

if [[ $PACKER_BUILDER_TYPE =~ docker ]]; then
    true
fi
