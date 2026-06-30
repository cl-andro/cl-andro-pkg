CLANDRO_PKG_HOMEPAGE=https://github.com/tree-sitter-grammars/tree-sitter-vim
CLANDRO_PKG_DESCRIPTION="Vimscript grammar for tree-sitter"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.8.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/tree-sitter-grammars/tree-sitter-vim/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=93cafb9a0269420362454ace725a118ff1c3e08dcdfdc228aa86334b54d53c2a
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
