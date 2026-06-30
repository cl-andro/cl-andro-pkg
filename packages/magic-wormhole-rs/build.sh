CLANDRO_PKG_HOMEPAGE="https://github.com/magic-wormhole/magic-wormhole.rs"
CLANDRO_PKG_DESCRIPTION=" Rust implementation of Magic Wormhole, with new features and enhancements"
CLANDRO_PKG_LICENSE="EUPL-1.2"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.7.6"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/magic-wormhole/magic-wormhole.rs/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=1d76e80108291f0a31e1a0e2e1d6199decb55bec73bc725baacb93ea0ae06e5e
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs "$CLANDRO_PKG_MAKE_PROCESSES" --target "$CARGO_TARGET_NAME" --release \
		--no-default-features --features "magic-wormhole/default,magic-wormhole/forwarding"
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" "target/${CARGO_TARGET_NAME}/release/wormhole-rs"
}
