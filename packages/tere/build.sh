CLANDRO_PKG_HOMEPAGE=https://github.com/mgunyho/tere
CLANDRO_PKG_DESCRIPTION="Terminal file explorer written in rust"
CLANDRO_PKG_LICENSE="EUPL-1.2"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.6.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/mgunyho/tere/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=7db94216b94abd42f48105c90e0e777593aaf867472615eb94dc2f77bb6a3cfb
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	rm -rf $CARGO_HOME/registry/src/*/rustix-*
	cargo fetch --target "${CARGO_TARGET_NAME}"

	for d in $CARGO_HOME/registry/src/*/rustix-*; do
		patch --silent -p1 -d ${d} < $CLANDRO_PKG_BUILDER_DIR/0001-rustix-fix-libc-removing-unsafe-on-makedev.diff || :
	done
}

clandro_step_make() {
	clandro_setup_rust

	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/tere
}
