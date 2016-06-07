#!/usr/bin/env bash

if ! grep -s /etc/network/interfaces.d /etc/network/interfaces; then
  echo 'source-directory /etc/network/interfaces.d' | tee -a /etc/network/interfaces
fi
