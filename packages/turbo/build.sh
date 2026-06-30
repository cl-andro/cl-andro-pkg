CLANDRO_PKG_HOMEPAGE=https://turborepo.dev/
CLANDRO_PKG_DESCRIPTION="High-performance build system for JS/TS"
CLANDRO_PKG_MAINTAINER="@xingguangcuican6666"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_VERSION="2.9.11"
CLANDRO_PKG_SRCURL="https://github.com/vercel/turborepo/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=7720e6d96bdabe51fb7cae82dbc31925b0177036a5e105ab24083d6b7e0e5b30
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=latest-release-tag

clandro_step_make() {
	clandro_setup_rust
	clandro_setup_capnp
	clandro_setup_protobuf
	cargo build --release --package turbo --target "$CARGO_TARGET_NAME"
}

clandro_step_make_install() {
	install -Dm755 ./target/"${CARGO_TARGET_NAME}"/release/turbo "${CLANDRO_PREFIX}"/bin/turbo
}
