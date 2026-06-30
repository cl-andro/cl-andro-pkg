CLANDRO_PKG_HOMEPAGE=https://github.com/SoptikHa2/desed
CLANDRO_PKG_DESCRIPTION="Demystifies and debugs your sed scripts"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/SoptikHa2/desed/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=73c75eaa65cccde5065a947e45daf1da889c054d0f3a3590d376d7090d4f651a
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/desed
}
