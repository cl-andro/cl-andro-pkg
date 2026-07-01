CLANDRO_PKG_HOMEPAGE=https://github.com/tree-sitter/tree-sitter-java
CLANDRO_PKG_DESCRIPTION="Java grammar for tree-sitter"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.23.5"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/tree-sitter/tree-sitter-java/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=cb199e0faae4b2c08425f88cbb51c1a9319612e7b96315a174a624db9bf3d9f0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE='newest-tag'
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	clandro_setup_treesitter
}

clandro_step_make() {
	clandro-tree-sitter build
}

clandro_step_make_install() {
	clandro-tree-sitter install
}
