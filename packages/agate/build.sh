CLANDRO_PKG_HOMEPAGE=https://github.com/mbrubeck/agate
CLANDRO_PKG_DESCRIPTION="Very simple server for the Gemini hypertext protocol"
CLANDRO_PKG_LICENSE="MIT, Apache-2.0"
CLANDRO_PKG_LICENSE_FILE="LICENSE-MIT, LICENSE-APACHE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.3.22"
CLANDRO_PKG_SRCURL=https://github.com/mbrubeck/agate/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=7fc67b7a1620cdc3d62f629dfd25e4c7eb28325f9ba6a7e95d36e633de286d0d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust

	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin $CLANDRO_PKG_SRCDIR/target/${CARGO_TARGET_NAME}/release/agate
}
