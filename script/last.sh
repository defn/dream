#!/usr/bin/env bash -ux

umask 022

passwd -l ubuntu
passwd -l root

chown -R ubuntu:ubuntu ~ubuntu

sync
