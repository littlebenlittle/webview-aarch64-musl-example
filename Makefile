webview.h=src/webview.h
rsync_warning=please set REMOTE_DIR ( hint: source .env )
out=app

.PHONY: build

build:
	g++ main.c `pkg-config --cflags --libs glib-2.0 gtk+-3.0 webkit2gtk-4.0` -o $(out)

rsync:
	@if [ -z "$$REMOTE_DIR" ]; then echo "$(rsync_warning)"; else rsync -vv "$(out)" "$$REMOTE_DIR"; fi
