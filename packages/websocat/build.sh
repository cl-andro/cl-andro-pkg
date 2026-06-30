CLANDRO_PKG_HOMEPAGE=https://github.com/vi/websocat
CLANDRO_PKG_DESCRIPTION="Command-line client for WebSockets, like netcat (or curl) for ws:// with advanced socat-like functions"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.14.1"
CLANDRO_PKG_SRCURL=https://github.com/vi/websocat/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=5c976c535800ca635b72839fe49d0fe4ad2479db8744c5a00f0cf911e4832e2d
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_rust

	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/websocat
}
