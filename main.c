#include "webview.h"

#ifdef WIN32
int WINAPI WinMain(HINSTANCE hInt, HINSTANCE hPrevInst, LPSTR lpCmdLine,
                   int nCmdShow) {
#else
int main() {
#endif
	webview_t w = webview_create(0, NULL);
	webview_set_title(w, "Webview Example");
	webview_run(w);
	webview_destroy(w);
	return 0;
}
