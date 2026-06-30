CLANDRO_PKG_HOMEPAGE=https://github.com/loichyan/nerdfix
CLANDRO_PKG_DESCRIPTION="nerdfix helps you to find/fix obsolete Nerd Font icons in your project."
CLANDRO_PKG_LICENSE="Apache-2.0, MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.4.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/loichyan/nerdfix/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e56f648db6bfa9a08d4b2adbf3862362ff66010f32c80dc076c0c674b36efd3c
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=latest-release-tag

clandro_step_pre_configure() {
	# do not pin the version of the rust toolchain
	rm -f rust-toolchain.toml
	clandro_setup_rust
}

clandro_step_make() {
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/nerdfix
}
