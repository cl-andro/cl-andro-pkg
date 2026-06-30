CLANDRO_PKG_HOMEPAGE=https://github.com/kakoune-lsp/kakoune-lsp
CLANDRO_PKG_DESCRIPTION="Language Server Protocol Client for the Kakoune editor"
CLANDRO_PKG_LICENSE="MIT, Unlicense"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="20.0.0"
CLANDRO_PKG_SRCURL=https://github.com/kakoune-lsp/kakoune-lsp/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=117d40d064dfc74941af8e9db52231fe6acde7bc5fe11ee2ae486c25d2730fb5
CLANDRO_PKG_CONFLICTS="kak-lsp"
CLANDRO_PKG_REPLACES="kak-lsp"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust

	rm Makefile
}

clandro_step_post_make_install() {
	rm -rf $CLANDRO_PREFIX/share/kak-lsp
	cp -r $CLANDRO_PKG_SRCDIR/rc $CLANDRO_PREFIX/share/kak-lsp
}
