CLANDRO_PKG_HOMEPAGE=https://github.com/tree-sitter/tree-sitter-python
CLANDRO_PKG_DESCRIPTION="Python grammar for tree-sitter"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.25.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/tree-sitter/tree-sitter-python/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4609a3665a620e117acf795ff01b9e965880f81745f287a16336f4ca86cf270c
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
