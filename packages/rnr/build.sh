CLANDRO_PKG_HOMEPAGE="https://github.com/ismaelgv/rnr"
CLANDRO_PKG_DESCRIPTION="Batch rename files and directories using regular expression (rust)"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@flosnvjx"
CLANDRO_PKG_VERSION="0.5.1"
CLANDRO_PKG_SRCURL="https://github.com/ismaelgv/rnr/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=af35b5d5afab08b01cab345686d7e7d2d37a33d268fa8827a8001c3164ef4722
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release --locked
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/rnr
	install -Dm600 -t $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME README.* CHANGELOG*
}
