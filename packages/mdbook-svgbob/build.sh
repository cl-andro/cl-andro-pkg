CLANDRO_PKG_HOMEPAGE=https://github.com/boozook/mdbook-svgbob
CLANDRO_PKG_DESCRIPTION="SvgBob mdbook preprocessor which swaps code-blocks with neat SVG"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.2.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/boozook/mdbook-svgbob/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=042e8ce79c31e215235659433c1b09754a7c8e67040d3346e0cf989061163179
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-svgbob
}
