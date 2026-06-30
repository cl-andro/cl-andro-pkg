CLANDRO_PKG_HOMEPAGE=https://github.com/sigoden/aichat
CLANDRO_PKG_DESCRIPTION="A powerful chatgpt cli"
CLANDRO_PKG_LICENSE="Apache-2.0,MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE-APACHE,LICENSE-MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.30.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/sigoden/aichat/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=e194cc89afc213a6e3169738221cae641c347421c4f2aacd5d6f4f7cc6edb387
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

# This package contains makefiles to run the tests. So, we need to override build steps.
clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs "$CLANDRO_PKG_MAKE_PROCESSES" --target "$CARGO_TARGET_NAME" --release
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" "target/${CARGO_TARGET_NAME}/release/aichat"
}
