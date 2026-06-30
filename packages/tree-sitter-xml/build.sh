CLANDRO_PKG_HOMEPAGE=https://github.com/tree-sitter-grammars/tree-sitter-xml
CLANDRO_PKG_DESCRIPTION="XML grammar for tree-sitter"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.7.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/tree-sitter-grammars/tree-sitter-xml/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4330a6b3685c2f66d108e1df0448eb40c468518c3a66f2c1607a924c262a3eb9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE='newest-tag'
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	clandro_setup_treesitter
}

clandro_step_make() {
	termux-tree-sitter build -s "xml/src"
}

clandro_step_make_install() {
	termux-tree-sitter install -s "xml/src"
}
