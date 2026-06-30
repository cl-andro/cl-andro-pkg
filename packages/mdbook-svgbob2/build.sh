CLANDRO_PKG_HOMEPAGE=https://github.com/matthiasbeyer/mdbook-svgbob2
CLANDRO_PKG_DESCRIPTION="Alternative mdbook preprocessor for svgbob"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.3.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/matthiasbeyer/mdbook-svgbob2/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9e36746b4975dfa3db996a3e890fea57810493c48aa18f7bd09dc4b5a76f5a96
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook-svgbob2
}
