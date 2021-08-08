#!/bin/ash

cd /mnt
if [ -d aarch64-linux-musl-cross ]; then exit 0; fi

musl_cc='https://musl.cc/aarch64-linux-musl-cross.tgz'
tar=aarch64-linux-musl-cross.tgz
wget -O $tar $musl_cc
trap "rm $tar" EXIT
tar -xf $tar
