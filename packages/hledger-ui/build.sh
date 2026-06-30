CLANDRO_PKG_HOMEPAGE=https://hledger.org/
CLANDRO_PKG_DESCRIPTION="hledger-ui - terminal interface (TUI) for hledger, a robust, friendly plain text accounting app."
CLANDRO_PKG_LICENSE="GPL-3.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.43.2
CLANDRO_PKG_SRCURL=https://hackage.haskell.org/package/hledger-ui-${CLANDRO_PKG_VERSION}/hledger-ui-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=dbd6b92afd4741811671fa3311384640a10c21afb60964133291d5f266b3e5f7
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_BUILD_DEPENDS="aosp-libs"
CLANDRO_PKG_DEPENDS="libffi, libiconv, libgmp, zlib, ncurses, asciinema"
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"

clandro_step_post_configure() {
	cabal get splitmix-0.1.3.1
	mv splitmix{-*,}

	for f in "$CLANDRO_PKG_BUILDER_DIR"/splitmix-patches/*.patch; do
		patch --silent -p1 -d splitmix < "$f"
	done

	cabal get entropy-0.4.1.11
	mv entropy{-*,}
	sed -i -E 's|(build-type:\s*)Custom|\1Simple|' entropy/entropy.cabal

	cat <<-EOF >>cabal.project.local
		packages: splitmix entropy

		package splitmix
			benchmarks: False
			tests: False

		package entropy
			flags: +donotgetentropy
	EOF

	if [[ "$CLANDRO_ON_DEVICE_BUILD" == false ]]; then # We do not need iserv for on device builds.
		clandro_setup_ghc_iserv
		cat <<-EOF >>cabal.project.local
			package *
			    ghc-options: -fexternal-interpreter -pgmi=$(command -v termux-ghc-iserv)
		EOF
	fi
}

clandro_step_make() {
	cabal --config="$CLANDRO_CABAL_CONFIG" build exe:hledger-ui
}
