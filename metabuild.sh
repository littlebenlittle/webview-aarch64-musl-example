#!/bin/bash

set -ex

if [ -z "$BUILD_COMMON" ]; then echo 'please set BUILD_COMMON (see README)'; exit 1; fi

podman run -ti --rm \
	-v $BUILD_COMMON:/mnt \
	-v ./fetch-musl-cross.sh:/fetch-musl-cross.sh \
	-w /mnt \
	alpine:3.13 \
	/fetch-musl-cross.sh

if [ -z "`podman image ls | grep builder | grep base`" ]; then
	ctr=`buildah from alpine:3.13`
	trap "buildah rm $ctr" EXIT
	buildah run $ctr apk add webkit2gtk-dev
	buildah commit $ctr builder:base
fi

ctr=`buildah from builder:base`
trap "buildah rm $ctr" EXIT
buildah config \
	--env PKG_CONFIG_PATH=/usr/lib/pkgconfig \
	$ctr
buildah commit $ctr builder
