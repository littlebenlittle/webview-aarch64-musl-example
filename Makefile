SHELL=/bin/bash
webview.h=src/webview.h

.PHONY: build

fetch-webview:
	@wget -O $(CURDIR)/webview.h https://raw.githubusercontent.com/webview/webview/master/webview.h

build:
	@if [ -z "$$BUILD_COMMON" ]; then echo 'please set BUILD_COMMON (see README)'; exit 1; fi
	@if [ ! -d $(CURDIR)/build/aarch64 ]; then mkdir -p $(CURDIR)/build/aarch64; fi
	@podman run -ti --rm \
		-v .:/mnt \
		-w /mnt \
		builder ash -c \
		'/opt/aarch64-linux-musl-cross/bin/aarch64-linux-musl-g++ main.c `pkg-config --cflags --libs glib-2.0 gtk+-3.0 webkit2gtk-4.0` -o build/aarch64/app'
