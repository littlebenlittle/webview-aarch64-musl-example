#!/bin/bash

set -ex

if [ -z "$BUILD_COMMON" ]; then echo 'please set BUILD_COMMON (hint: source .env )'; exit 1; fi
if [ ! -d $BUILD_COMMON ]; then mkdir -p $BUILD_COMMON; fi

if [ ! -d "$BUILD_COMMON/aarch64-linux-musl-cross" ]; then
	musl_cc='https://musl.cc/aarch64-linux-musl-cross.tgz'
	pushd $BUILD_COMMON 
		tar=aarch64-linux-musl-cross.tgz
		wget -O $tar $musl_cc
		trap "rm `pwd`/$tar" EXIT
		tar -xf $tar
	popd
fi

if [ -z "`podman image ls | grep builder | grep base`" ]; then
	ctr=`buildah from alpine:3.13`
	trap "buildah rm $ctr" EXIT
	buildah run $ctr apk add webkit2gtk-dev
	buildah add $ctr $BUILD_COMMON/aarch64-linux-musl-cross /opt/aarch64-linux-musl-cross
	buildah commit $ctr builder:base
fi

ctr=`buildah from builder:base`
trap "buildah rm $ctr" EXIT
buildah run $ctr ash -c 'echo export PATH=\$PATH:/opt/aarch64-linux-musl-cross/bin > /etc/profile.d/path.sh'
buildah config \
	--env PKG_CONFIG_PATH=/usr/lib/pkgconfig \
	$ctr
buildah commit $ctr builder
