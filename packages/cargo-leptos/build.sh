CLANDRO_PKG_HOMEPAGE=https://github.com/leptos-rs/cargo-leptos
CLANDRO_PKG_DESCRIPTION="Build tool for the Rust framework Leptos"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.3.6"
CLANDRO_PKG_SRCURL=https://github.com/leptos-rs/cargo-leptos/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d3aa977fab47329983ff85c5f41bae55a3f1e89673992c905a2fbdc40c50d727
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
	export OPENSSL_NO_VENDOR=1
}
