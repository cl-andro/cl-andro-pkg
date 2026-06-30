CLANDRO_PKG_HOMEPAGE=https://github.com/rizsotto/Bear
CLANDRO_PKG_DESCRIPTION="Bear is a tool that generates a compilation database for clang tooling."
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="Nguyen Khanh @nguynkhn"
CLANDRO_PKG_VERSION="4.1.3"
CLANDRO_PKG_SRCURL="https://github.com/rizsotto/Bear/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=87a5b385b01000a3ae2c69f535384dca33da7f23925a523ba177f98b1bb7f301
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_make() {
	cargo build \
		--jobs "${CLANDRO_PKG_MAKE_PROCESSES}" \
		--target "${CARGO_TARGET_NAME}" \
		--release
}

clandro_step_make_install() {
	rm -rf target/release
	mv "target/$CARGO_TARGET_NAME/release" target/release
	scripts/install.sh
}
