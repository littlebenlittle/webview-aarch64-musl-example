
# Webview Example

## Purpose

This is a webview example app intended to be compiled for the Pine64 Pinephone.

## Build

### pmbootstrap

```sh
pmb chroot
git clone https://github.com/littlebenlittle/webview-aarch64-musl-example.git
cd webview-aarch64-musl-example
make build
```

### Manual QEMU

```sh
arch=aarch64
wget https://raw.githubusercontent.com/alpinelinux/alpine-chroot-install/v0.13.0/alpine-chroot-install
sha1sum <(cat alpine-chroot-install) <(echo "44406f1a060b9f08b7e5ac264c8b9527b32fb54  alpine-chroot-install") || exit 1
chmod +x alpine-chroot-install
sudo alpine-chroot-install -a $arch -d /alpine-aarch64 -r 'build-essential webkit2gtk-dev'
/alpine-aarch64/enter-chroot -u user
```

In chroot

```sh
make build
```

## Run

Configure connection to remote device:

```sh
cat >.env <<EOF
export REMOTE_HOST=10.0.0.123
export REMOTE_USER=user@\$REMOTE_HOST
export REMOTE_DIR=\$REMOTE_USER:/home/user
export LOCAL=\$PWD/.local
EOF
source .env
```

```sh
make rsync
```
