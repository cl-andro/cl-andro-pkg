CLANDRO_PKG_HOMEPAGE=https://github.com/tree-sitter-grammars/tree-sitter-markdown
CLANDRO_PKG_DESCRIPTION="Markdown grammar for tree-sitter"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.5.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/tree-sitter-grammars/tree-sitter-markdown/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=df845b1ab7c7c163ec57d7fa17170c92b04be199bddab02523636efec5224ab6
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE='newest-tag'
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_LIBDIR=$CLANDRO__PREFIX__LIB_SUBDIR
-DCMAKE_INSTALL_INCLUDEDIR=$CLANDRO__PREFIX__INCLUDE_SUBDIR
-DALL_EXTENSIONS=ON
"

clandro_step_configure() {
	clandro_setup_treesitter
}

clandro_step_make() {
	local parser
	for parser in "markdown" "markdown-inline"; do
		clandro-tree-sitter build -s "tree-sitter-$parser/src"
	done
}

clandro_step_make_install() {
	local parser
	for parser in "markdown" "markdown-inline"; do
		clandro-tree-sitter install -s "tree-sitter-$parser/src"
	done
}
