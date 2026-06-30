CLANDRO_PKG_HOMEPAGE=https://github.com/tree-sitter/tree-sitter-json
CLANDRO_PKG_DESCRIPTION="JSON grammar for tree-sitter"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.24.8"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/tree-sitter/tree-sitter-json/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=acf6e8362457e819ed8b613f2ad9a0e1b621a77556c296f3abea58f7880a9213
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE='newest-tag'
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	clandro_setup_treesitter
}

clandro_step_make() {
	termux-tree-sitter build
}

clandro_step_make_install() {
	termux-tree-sitter install
}
