CLANDRO_PKG_HOMEPAGE=https://github.com/tree-sitter-grammars/tree-sitter-lua
CLANDRO_PKG_DESCRIPTION="Lua grammar for tree-sitter"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.5.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/tree-sitter-grammars/tree-sitter-lua/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=cf01b93f4b61b96a6d27942cf28eeda4cbce7d503c3bef773a8930b3d778a2d9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE='newest-tag'
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_LIBDIR=$CLANDRO__PREFIX__LIB_SUBDIR
-DCMAKE_INSTALL_INCLUDEDIR=$CLANDRO__PREFIX__INCLUDE_SUBDIR
"

clandro_step_configure() {
	clandro_setup_treesitter
}

clandro_step_make() {
	termux-tree-sitter build
}

clandro_step_make_install() {
	termux-tree-sitter install
}
