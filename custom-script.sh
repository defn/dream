#!/usr/bin/env bash

function main {
  set -efux

  aptitude update

  aptitude -y install git vim unzip curl language-pack-en
  aptitude -y install python-setuptools python-dev libffi-dev libssl-dev
  aptitude -y install libreadline-dev
  aptitude -y install gcc-multilib g++-multilib
  aptitude -y install openjdk-7-jdk

  aptitude -y purge nano
}

main "$@"

