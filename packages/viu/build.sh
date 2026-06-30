CLANDRO_PKG_HOMEPAGE=https://github.com/atanunq/viu
CLANDRO_PKG_DESCRIPTION="Terminal image viewer with native support for iTerm and Kitty"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE-MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.6.1"
CLANDRO_PKG_SRCURL=https://github.com/atanunq/viu/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=639c1fe14aee5e34b635de041ac77177e2959cf26072d8ef69c444b15c8273bd
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_rust

	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/viu
}
