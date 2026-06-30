CLANDRO_PKG_HOMEPAGE=https://github.com/BLAKE3-team/BLAKE3/tree/master/b3sum
CLANDRO_PKG_DESCRIPTION="A command line utility for calculating BLAKE3 hashes, similar to Coreutils tools like b2sum or md5sum"
CLANDRO_PKG_LICENSE="CC0-1.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.8.5"
CLANDRO_PKG_SRCURL=https://github.com/BLAKE3-team/BLAKE3/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=220bd81286e2a0585beac66d41ac3f4c2c33ae8a4e339fc88cf22d5e00514fe9
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_rust

	cd $CLANDRO_PKG_SRCDIR/b3sum

	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin $CLANDRO_PKG_SRCDIR/b3sum/target/${CARGO_TARGET_NAME}/release/b3sum
}
