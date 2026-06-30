CLANDRO_PKG_HOMEPAGE=https://github.com/crowdagger/crowbook
CLANDRO_PKG_DESCRIPTION="Allows you to write a book in Markdown without worrying about formatting or typography"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.17.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/crowdagger/crowbook/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=13c628722fedf1bfebc0fd334e9ffa41a62888e3195d2ad1e5ea851694dc4a4c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/crowbook
}
