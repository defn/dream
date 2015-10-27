#!/usr/bin/env bash

function main {
  set -efux

  apt-get -y install git vim unzip
  apt-get -y install python-setuptools python-dev libffi-dev libssl-dev
  apt-get -y install libreadline-dev

  apt-get -y purge nano
}

main "$@"
