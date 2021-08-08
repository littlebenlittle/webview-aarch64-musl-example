SHELL=/bin/bash
webview.h=src/webview.h
cmd=podman run -ti --rm -v .:/mnt -v $$BUILD_COMMON:/opt/build-common -w /mnt builder
pkg_config=pkg-config --cflags --libs glib-2.0 gtk+-3.0 webkit2gtk-4.0
aarch64=build/aarch64

.PHONY: build

fetch-webview:
	@wget -O $(CURDIR)/webview.h https://raw.githubusercontent.com/webview/webview/master/webview.h

build:
	@if [ -z "$$BUILD_COMMON" ]; then echo 'please set BUILD_COMMON (see README)'; exit 1; fi
	@if [ -z "$$MUSL_CROSS_PATH" ]; then echo 'please set MUSL_CROSS_PATH (see README)'; exit 1; fi
	@if [ ! -d $(CURDIR)/$(aarch64) ]; then mkdir -p $(CURDIR)/$(aarch64); fi
	$(cmd) ash -c 'PATH=$$PATH:/opt/build-common/aarch64-linux-musl-cross/bin aarch64-linux-musl-g++ main.c `$(pkg_config)` -o $(aarch64)/app'
