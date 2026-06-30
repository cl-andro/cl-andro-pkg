CLANDRO_PKG_HOMEPAGE=https://github.com/bergercookie/asm-lsp
CLANDRO_PKG_DESCRIPTION="language server for NASM/GAS/GO assembly"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_LICENSE_FILE="../LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.10.1"
CLANDRO_PKG_BUILD_DEPENDS="openssl"
CLANDRO_PKG_SRCURL=https://github.com/bergercookie/asm-lsp/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=9500dd7234966ae9fa57d8759edf1d165acd06c4924d7dbeddb7d52eb0ce59d6
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust

	CLANDRO_PKG_SRCDIR+="/asm-lsp"
	CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_SRCDIR"
}

clandro_step_make() {
	cargo fetch --target "${CARGO_TARGET_NAME}"

	local d
	for d in $HOME/.cargo/registry/src/*/memmap2-*; do
		patch --silent -p1 -d "${d}" < "$CLANDRO_PKG_BUILDER_DIR/memmap2.diff" || :
	done
}
