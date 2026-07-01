CLANDRO_PKG_HOMEPAGE=https://github.com/neovim/tree-sitter-vimdoc
CLANDRO_PKG_DESCRIPTION="Tree-sitter parser for Vim help files"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="4.1.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/neovim/tree-sitter-vimdoc/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=020e8f117f648c8697fca967995c342e92dbd81dab137a115cc7555207fbc84f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE='newest-tag'
CLANDRO_PKG_BUILD_IN_SRC=true
# This one is different from the tree-sitter-grammars/* parsers
# It does not have a CMakeLists.txt file, so we're using `make`
CLANDRO_PKG_EXTRA_MAKE_ARGS="
PARSER_URL=https://github.com/neovim/tree-sitter-vimdoc
"

clandro_step_configure() {
	clandro_setup_treesitter
}

clandro_step_make() {
	clandro-tree-sitter build
}

clandro_step_make_install() {
	clandro-tree-sitter install
}
