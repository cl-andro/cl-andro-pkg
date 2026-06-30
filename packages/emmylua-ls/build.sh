CLANDRO_PKG_HOMEPAGE=https://github.com/EmmyLuaLs/emmylua-analyzer-rust
CLANDRO_PKG_DESCRIPTION="Emmy Lua Language Server coded in Rust"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Steven Xu @stevenxxiu"
CLANDRO_PKG_VERSION="0.22.0"
CLANDRO_PKG_SRCURL=https://github.com/EmmyLuaLs/emmylua-analyzer-rust/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d1b7eec2f607b58a2bb3599530de3ef206911f521d4e5a4eb229d1fd6fbee7c2
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	# ld.lld: error: undefined symbol: __atomic_load_8
	if [[ "$CLANDRO_ARCH" == "i686" ]]; then
		local -u env_host="${CARGO_TARGET_NAME//-/_}"
		export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=$(${CC} -print-libgcc-file-name)"
	fi
}

clandro_step_make() {
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/emmylua_ls
	install -Dm755 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/emmylua_doc_cli
	install -Dm755 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/emmylua_check
}
