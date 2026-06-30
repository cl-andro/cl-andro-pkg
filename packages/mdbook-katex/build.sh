CLANDRO_PKG_HOMEPAGE=https://github.com/lzanini/mdbook-katex
CLANDRO_PKG_DESCRIPTION="A preprocessor for mdBook, pre-rendering LaTex equations to HTML at build time"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.4"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/lzanini/mdbook-katex/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d06621802fffb34c9bc96925e48eb6c0ff71ec70b30a7b7d09145f89d6c60573
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+(?!-)"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_make() {
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-katex
}
