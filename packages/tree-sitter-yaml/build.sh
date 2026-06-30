CLANDRO_PKG_HOMEPAGE=https://github.com/tree-sitter-grammars/tree-sitter-yaml
CLANDRO_PKG_DESCRIPTION="YAML grammar for tree-sitter"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.7.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/tree-sitter-grammars/tree-sitter-yaml/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=aeaff5731bb8b66c7054c8aed33cd5edea5f4cd2ac71654f3f6c2ba2073d8fac
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE='newest-tag'
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_FORCE_CMAKE=true

clandro_step_configure() {
	clandro_setup_treesitter
}

clandro_step_make() {
	termux-tree-sitter build
}

clandro_step_make_install() {
	termux-tree-sitter install
}
