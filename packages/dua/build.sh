CLANDRO_PKG_HOMEPAGE=https://github.com/Byron/dua-cli
CLANDRO_PKG_DESCRIPTION="View disk space usage and delete unwanted data, fast"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.34.0"
CLANDRO_PKG_SRCURL=https://github.com/Byron/dua-cli/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=eaa924f50efb425302c124f170644e95a08f8dad1f627b86f50d033ca5feb0c1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_make() {
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release --no-default-features --features tui-crossplatform
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/dua
}
