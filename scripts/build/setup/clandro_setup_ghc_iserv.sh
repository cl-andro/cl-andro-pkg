# shellcheck shell=bash
# This provides an utility function to setup iserv (external interpreter of ghc) to cross-compile haskell-template.
clandro_setup_ghc_iserv() {
	local CLANDRO_ISERV_BIN="$CLANDRO_COMMON_CACHEDIR/iserv-bin-$CLANDRO_ARCH"
	local CLANDRO_ISERV_BIN_NAME="clandro-ghc-iserv"

	clandro_setup_proot

	export PATH="$CLANDRO_ISERV_BIN:$PATH"

	[[ -d "$CLANDRO_ISERV_BIN" ]] && return

	mkdir -p "$CLANDRO_ISERV_BIN"

	local ghc_bin_dir
	ghc_bin_dir="$(ghc --print-libdir)/../bin"

	cat <<-EOF >"$CLANDRO_ISERV_BIN/$CLANDRO_ISERV_BIN_NAME"
		#!/bin/bash
		clandro-proot-run $ghc_bin_dir/ghc-iserv "\$@"
	EOF

	cat <<-EOF >"$CLANDRO_ISERV_BIN/${CLANDRO_ISERV_BIN_NAME/iserv/iserv-dyn}"
		#!/bin/bash
		clandro-proot-run $ghc_bin_dir/ghc-iserv-dyn "\$@"
	EOF

	chmod +x "$CLANDRO_ISERV_BIN/$CLANDRO_ISERV_BIN_NAME"
	chmod +x "$CLANDRO_ISERV_BIN/${CLANDRO_ISERV_BIN_NAME/iserv/iserv-dyn}"
}
