#!/bin/bash

set -ex

if [ -z "$BUILD_COMMON" ]; then echo 'please set BUILD_COMMON (see README)'; exit 1; fi

podman run -ti --rm \
	-v $BUILD_COMMON:/mnt \
	-v ./fetch-musl-cross.sh:/fetch-musl-cross.sh \
	-w /mnt \
	alpine:3.13 \
	/fetch-musl-cross.sh

ctr=`buildah from alpine:3.13`
trap "buildah rm $ctr" EXIT
buildah run $ctr apk add --arch aarch64 webkit2gtk-dev
buildah commit $ctr builder
