CLANDRO_PKG_HOMEPAGE=https://github.com/mozilla/geckodriver
CLANDRO_PKG_DESCRIPTION="Proxy for using W3C WebDriver-compatible clients to interact with Gecko-based browsers"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.36.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/mozilla/geckodriver/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=03d8fe48d32a711318b2fffc93019874731318de44f36a9731935d10bdea762b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_RECOMMENDS="firefox"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --bin geckodriver --release
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/geckodriver
	ln -sf $CLANDRO_PREFIX/bin/geckodriver $CLANDRO_PREFIX/bin/wires
}
