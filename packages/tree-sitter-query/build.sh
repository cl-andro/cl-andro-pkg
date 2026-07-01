CLANDRO_PKG_HOMEPAGE=https://github.com/tree-sitter-grammars/tree-sitter-query
CLANDRO_PKG_DESCRIPTION="TS query grammar for tree-sitter"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.8.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/tree-sitter-grammars/tree-sitter-query/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c2b23b9a54cffcc999ded4a5d3949daf338bebb7945dece229f832332e6e6a7d
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
	clandro-tree-sitter build
}

clandro_step_make_install() {
	clandro-tree-sitter install
}
