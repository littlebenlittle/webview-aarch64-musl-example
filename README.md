
# Webview Example

## Purpose

This is a webview example app intended to be compiled for the Pine64 Pinephone.

## Build

```sh
cat >.env <<EOF
export BUILD_COMMON=$PWD/.local/etc/build-common
EOF
source .env
./build/metabuild.sh
make build
```
