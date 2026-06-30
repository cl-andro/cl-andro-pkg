CLANDRO_PKG_HOMEPAGE="https://github.com/jblindsay/whitebox-tools"
CLANDRO_PKG_DESCRIPTION="An advanced geospatial data analysis platform"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/jblindsay/whitebox-tools/archive/refs/tags/v2.0.0.tar.gz"
CLANDRO_PKG_SHA256=18705fc948bdb2f96cd816e5a72d36b9cc460aa8c910383d23fdbd61641aab60
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo update # Fix rust 1.73 incompatibility - can probably be removed when bumping version
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin/whitebox_tools  \
		target/${CARGO_TARGET_NAME}/release/whitebox_tools
}
