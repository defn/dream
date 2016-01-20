#!/bin/bash -ux

env | grep -i proxy
uname -a
echo "Acquire::http::Proxy \"$http_proxy\";" | tee /etc/apt/apt.conf.d/99boxcache
apt-get install -y aptitude
aptitude -y update
apt-get -y autoremove
