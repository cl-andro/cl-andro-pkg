CLANDRO_PKG_HOMEPAGE=https://github.com/dalance/amber
CLANDRO_PKG_DESCRIPTION="A code search / replace tool"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.6.1"
CLANDRO_PKG_SRCURL=https://github.com/dalance/amber/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=58ca7d172e68acde06c80039762073f6fb700a75d1013aece84f310a4535c277
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_REPLACES="amr, ambs"
CLANDRO_PKG_BREAKS="amr, ambs"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_rust

	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/ambr
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/ambs
}
