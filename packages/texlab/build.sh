CLANDRO_PKG_HOMEPAGE=https://texlab.netlify.app/
CLANDRO_PKG_DESCRIPTION="A cross-platform implementation of the Language Server Protocol providing rich cross-editing support for the LaTeX typesetting system"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.25.1"
CLANDRO_PKG_SRCURL=git+https://github.com/latex-lsp/texlab
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/texlab
}
