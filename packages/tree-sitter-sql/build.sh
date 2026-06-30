CLANDRO_PKG_HOMEPAGE=https://github.com/derekstride/tree-sitter-sql
CLANDRO_PKG_DESCRIPTION="SQL grammar for tree-sitter"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.3.11"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/derekstride/tree-sitter-sql/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1fe13cb1e50dd9da9f22aed3cb9430fc9dae05a734a6049926fc12f6d8ecd3ae
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE='newest-tag'
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	clandro_setup_nodejs
	clandro_setup_treesitter
}

clandro_step_make() {
	termux-tree-sitter generate
	termux-tree-sitter build -n "sql"
}

clandro_step_make_install() {
	termux-tree-sitter install -n "sql"
}
