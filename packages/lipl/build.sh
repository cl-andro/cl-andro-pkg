CLANDRO_PKG_HOMEPAGE=https://github.com/yxdunc/lipl
CLANDRO_PKG_DESCRIPTION="A command line tool that is similar to watch but has extended functions for commands outputing a number"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.1.3
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://github.com/yxdunc/lipl
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/lipl
}
