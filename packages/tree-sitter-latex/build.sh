CLANDRO_PKG_HOMEPAGE=https://github.com/latex-lsp/tree-sitter-latex
CLANDRO_PKG_DESCRIPTION="LaTeX grammar for tree-sitter"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.6.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/latex-lsp/tree-sitter-latex/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=90d2085c9a46f5da0918ead2fa9b764defd57c34d493f06160f796014d2fd16a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	clandro_setup_nodejs
	clandro_setup_treesitter
}

clandro_step_make() {
	clandro-tree-sitter generate
	clandro-tree-sitter build
}

clandro_step_make_install() {
	clandro-tree-sitter install
}
