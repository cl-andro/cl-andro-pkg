CLANDRO_PKG_HOMEPAGE=https://github.com/rust-lang/rust-bindgen
CLANDRO_PKG_DESCRIPTION="Automatically generates Rust FFI bindings to C (and some C++) libraries"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.72.1"
CLANDRO_PKG_SRCURL=https://github.com/rust-lang/rust-bindgen/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4ffb17061b2d71f19c5062d2e17e64107248f484f9775c0b7d30a16a8238dfd1
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_make() {
	local BUILD_TYPE=
	if [ $CLANDRO_DEBUG_BUILD = false ]; then
		BUILD_TYPE=--release
	fi

	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES \
		--target $CARGO_TARGET_NAME ${BUILD_TYPE}
}

clandro_step_make_install() {
	local BUILD_TYPE=release
	if [ $CLANDRO_DEBUG_BUILD = true ]; then
		BUILD_TYPE=debug
	fi

	install -Dm755 -t $CLANDRO_PREFIX/bin \
		target/${CARGO_TARGET_NAME}/${BUILD_TYPE}/bindgen
}
