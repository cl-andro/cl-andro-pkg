CLANDRO_PKG_HOMEPAGE=https://github.com/spacejam/sled
CLANDRO_PKG_DESCRIPTION="A lightweight pure-rust high-performance transactional embedded database"
CLANDRO_PKG_LICENSE="Apache-2.0, MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE-APACHE, LICENSE-MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.34.7
CLANDRO_PKG_SRCURL=https://github.com/spacejam/sled/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=dd1c757464b970a4eb73c954b345be63655c84bb1de249af3c3a609c57763046

clandro_step_post_get_source() {
	sed -e "s%\@CLANDRO_PKG_VERSION\@%${CLANDRO_PKG_VERSION}%g" \
		$CLANDRO_PKG_BUILDER_DIR/bindings-sled-native-Cargo.toml.diff | \
		patch --silent -p1
}

clandro_step_pre_configure() {
	CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_SRCDIR/bindings/sled-native"
}

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm600 -t $CLANDRO_PREFIX/lib target/${CARGO_TARGET_NAME}/release/libsled.so
}
