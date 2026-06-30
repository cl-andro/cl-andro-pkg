CLANDRO_PKG_HOMEPAGE=https://github.com/pemistahl/grex
CLANDRO_PKG_DESCRIPTION="Simplifies the task of creating regular expressions"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.6"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/pemistahl/grex/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=2ab9cb4c3d921711f23ea33a9e60dc11e9eaab450b16d1f2247bea2276822433
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/grex
}
