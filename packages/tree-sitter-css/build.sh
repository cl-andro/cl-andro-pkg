CLANDRO_PKG_HOMEPAGE=https://github.com/tree-sitter/tree-sitter-css
CLANDRO_PKG_DESCRIPTION="CSS grammar for tree-sitter"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.25.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/tree-sitter/tree-sitter-css/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=03965344d8c0435dc54fb45b281578420bb7db8b99df4d34e7e74105a274cb79
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE='newest-tag'
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	clandro_setup_nodejs
	clandro_setup_treesitter
}

clandro_step_make() {
	termux-tree-sitter generate
	termux-tree-sitter build
}

clandro_step_make_install() {
	termux-tree-sitter install
}
