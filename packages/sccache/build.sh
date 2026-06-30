CLANDRO_PKG_HOMEPAGE=https://github.com/mozilla/sccache
CLANDRO_PKG_DESCRIPTION="sccache is ccache with cloud storage"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.15.0"
CLANDRO_PKG_SRCURL=https://github.com/mozilla/sccache/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6e69b88f2f88982dc6389f68a6624b35502b5a2760a6a8a07bdb10a250ed98df
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/sccache
}
