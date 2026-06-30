CLANDRO_PKG_HOMEPAGE=https://github.com/FreeMasen/mdbook-presentation-preprocessor
CLANDRO_PKG_DESCRIPTION="A preprocessor for utilizing an MDBook as slides for a presentation"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.3.1"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/FreeMasen/mdbook-presentation-preprocessor/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=477eb3104bfe216ebd2067bad97cc3e5a2116ae37bd3819cf523771d315733c6
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-presentation-preprocessor
}
