CLANDRO_PKG_HOMEPAGE=https://github.com/bytecodealliance/wasm-component-ld
CLANDRO_PKG_DESCRIPTION="Command line linker for creating WebAssembly components"
CLANDRO_PKG_LICENSE="Apache-2.0, MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE-APACHE, LICENSE-Apache-2.0_WITH_LLVM-exception, LICENSE-MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.5.22"
CLANDRO_PKG_SRCURL=https://github.com/bytecodealliance/wasm-component-ld/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=152c53c2981665ff73fc97a9906726d5253afa26ad1ae58a3d02ba702e84dcb3
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_make() {
	cargo build --jobs "${CLANDRO_PKG_MAKE_PROCESSES}" --target "${CARGO_TARGET_NAME}" --release
}

clandro_step_make_install() {
	install -Dm755 -t "${CLANDRO_PREFIX}/bin" "target/${CARGO_TARGET_NAME}/release/wasm-component-ld"
}
