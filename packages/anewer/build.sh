CLANDRO_PKG_HOMEPAGE="https://github.com/ysf/anewer"
CLANDRO_PKG_DESCRIPTION="Append lines from stdin to a file if these lines do not present in that file (aHash-based uniq)"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@flosnvjx"
CLANDRO_PKG_VERSION="0.1.6"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/ysf/anewer/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=0f7d85dcba7cee291f63b8475a74806d385be768a43c2bf039fc32198026d918
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release --locked
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/anewer
	install -Dm600 -t $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME README.*
}
