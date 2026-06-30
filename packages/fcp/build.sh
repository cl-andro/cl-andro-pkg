CLANDRO_PKG_HOMEPAGE=https://github.com/Svetlitski/fcp
CLANDRO_PKG_DESCRIPTION="A significantly faster alternative to the classic Unix cp(1) command"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.2.1
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=git+https://github.com/Svetlitski/fcp
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/fcp
}
