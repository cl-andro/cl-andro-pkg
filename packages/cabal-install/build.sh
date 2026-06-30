CLANDRO_PKG_HOMEPAGE="https://www.haskell.org/cabal/"
CLANDRO_PKG_DESCRIPTION="The command-line interface for Haskell-Cabal and Hackage"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="Aditya Alok <alok@termux.org> & @clandro"
CLANDRO_PKG_VERSION=3.14.1.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://hackage.haskell.org/package/cabal-install-${CLANDRO_PKG_VERSION}/cabal-install-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=f11d364ab87fb46275a987e60453857732147780a8c592460eec8a16dbb6bace
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_SUGGESTS="ghc, dnsutils"
CLANDRO_PKG_DEPENDS="libffi, libiconv, libgmp, zlib, libandroid-posix-semaphore"
CLANDRO_PKG_BUILD_DEPENDS="aosp-libs"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-f-native-dns --ghc-options=-optl-landroid-posix-semaphore"

# Iserv has some linking problem on i686.
# ```
# 	ghc-iserv: /home/builder/.termux-build/_cache/ghc-cross-9.12.1-i686-runtime/lib/ghc-9.12.1/lib/i386-linux-ghc-9.12.1-inplace/ghc-prim-0.13.0-inplace/libHSghc-prim-0.13.0-inplace.a: unhandled ELF relocation(Rel) type 10
# 	ghc-iserv: Failed to lookup symbol: ghczmprim_GHCziTypes_ZMZN_closure
# 	ghc-iserv: ^^ Could not load 'ghczmprim_GHCziCString_unpackCStringzh_closure', dependency unresolved. See top entry above.
# ```
# Disabling it for now. # TODO: Fix it.
CLANDRO_PKG_EXCLUDED_ARCHES="i686"

clandro_step_post_configure() {
	cabal get splitmix-0.1.3.1
	mv splitmix{-*,}

	for f in "$CLANDRO_PKG_BUILDER_DIR"/splitmix-patches/*.patch; do
		patch --silent -p1 -d splitmix < "$f"
	done

	cat <<-EOF >>cabal.project.local
		packages: splitmix

		package splitmix
			benchmarks: False
			tests: False
	EOF

	if [[ "$CLANDRO_ON_DEVICE_BUILD" == false ]]; then # We do not need iserv for on device builds.
		clandro_setup_ghc_iserv
		cat <<-EOF >>cabal.project.local
			package *
			  ghc-options: -fexternal-interpreter -pgmi=$(command -v termux-ghc-iserv)
		EOF
	fi

	if [[ "$CLANDRO_ARCH" == "arm" ]]; then
		cat <<-EOF >>cabal.project.local
			package atomic-counter
			  flags: +no-cmm
		EOF
	fi
}
