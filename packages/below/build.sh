# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://github.com/facebookincubator/below
CLANDRO_PKG_DESCRIPTION="An interactive tool to view and record historical system data"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.11.0"
CLANDRO_PKG_SRCURL=https://github.com/facebookincubator/below/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=bc5cb3a5d9b62768bbabe09431737d631e244fffcc06dada88c3f6c81a23da9a
CLANDRO_PKG_DEPENDS="libelf, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_pre_configure() {
	clandro_setup_rust
	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	rm -rf "$CARGO_HOME"/registry/src/*/nix-*
	rm -rf "$CARGO_HOME"/registry/src/*/libbpf-sys-*
	rm -rf "$CARGO_HOME"/registry/src/*/openat-*

	cargo update

	cargo fetch --target $CARGO_TARGET_NAME

	local d p
	for d in "$CARGO_HOME"/registry/src/*/libbpf-sys-*; do
		for p in libbpf-sys-0.6.0-1-libbpf-include-linux-{compiler,types}.h.diff; do
			patch --silent -p1 -d ${d} \
				< "$CLANDRO_PKG_BUILDER_DIR/${p}" || :
		done
	done

	for d in "$CARGO_HOME"/registry/src/*/nix-*; do
		patch --silent -p1 -d "$d" <  "$CLANDRO_PKG_BUILDER_DIR"/nix-0.20.0-src-net-if_.rs.diff || :
	done

	for d in "$CARGO_HOME"/registry/src/*/openat-*; do
		patch --silent -p1 -d "$d" <  "$CLANDRO_PKG_BUILDER_DIR"/openat-st_mode-32-bit.diff || :
	done

	local _CARGO_TARGET_LIBDIR=target/$CARGO_TARGET_NAME/release/deps
	mkdir -p $_CARGO_TARGET_LIBDIR
	local lib
	for lib in lib{elf,z}.so; do
		ln -sf $CLANDRO_PREFIX/lib/${lib} $_CARGO_TARGET_LIBDIR/
	done

	# prevents "gcc: error: unrecognized command-line option '-mfpu=neon'" when targeting 32-bit
	unset CFLAGS
}

clandro_step_make() {
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/below
}
