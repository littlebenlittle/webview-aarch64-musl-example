#!/bin/bash

set -ex

ctr=`buildah from alpine:3.13`
trap "buildah rm $ctr" EXIT

fetch_cross=`mktemp`
trap "rm $fetch_cross" EXIT

cat >$fetch_cross <<EOF
set -ex
cd /opt
wget https://musl.cc/aarch64-linux-musl-cross.tgz
tar -xf aarch64-linux-musl-cross.tgz
rm aarch64-linux-musl-cross.tgz
EOF

buildah add $ctr $fetch_cross /fetch-musl-cross.sh
buildah run $ctr ash /fetch-musl-cross.sh
buildah run $ctr rm /fetch-musl-cross.sh
buildah run $ctr apk add --arch aarch64 webkit2gtk-dev
buildah commit $ctr builder
