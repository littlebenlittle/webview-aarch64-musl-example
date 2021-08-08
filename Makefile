SHELL=/bin/bash
webview.h=src/webview.h
cmd=podman run -ti --rm -v .:/mnt -w /mnt builder
pkg_config=pkg-config --cflags --libs glib-2.0 gtk+-3.0 webkit2gtk-4.0
aarch64=build/aarch64

.PHONY: build

fetch:
	@wget -O $(CURDIR)/webview.h https://raw.githubusercontent.com/webview/webview/master/webview.h

build:
	@if [ ! -d $(CURDIR)/$(aarch64) ]; then mkdir -p $(CURDIR)/$(aarch64); fi
	@$(cmd) ash -c 'source /etc/profile; aarch64-linux-musl-g++ main.c `$(pkg_config)` -o $(aarch64)/app'
