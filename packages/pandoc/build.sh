CLANDRO_PKG_HOMEPAGE=https://pandoc.org/
CLANDRO_PKG_DESCRIPTION="Universal markup converter"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="Aditya Alok <alok@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="3.9"
CLANDRO_PKG_SRCURL="https://hackage.haskell.org/package/pandoc-cli-$CLANDRO_PKG_VERSION/pandoc-cli-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=dd6e00c53da0ef12d75a21a643d7f0a1cdd8cb81178f725280124bda20aa24a9
CLANDRO_PKG_DEPENDS="libffi, libiconv, libgmp, lua54, zlib"
CLANDRO_PKG_BUILD_DEPENDS="aosp-libs"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-f+lua -f+server
-c lua+system-lua
-c lua+pkg-config
-c lua+cross-compile
-c pandoc+embed_data_files
"

CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686" # Upstream doesn't support 32bit.

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

	cabal get xml-conduit-1.10.0.0 # NOTE: Confirm version before updating.
	mv xml-conduit{-1.10.0.0,}

	# We cannot use `Custom` build while cross-compiling:
	sed -i -E 's|(build-type:\s*)Custom|\1Simple|' ./xml-conduit/xml-conduit.cabal

	if [[ "$CLANDRO_ON_DEVICE_BUILD" == false ]]; then # We do not need iserv for on device builds.
		clandro_setup_ghc_iserv
		cat <<-EOF >>cabal.project.local
			packages: ./xml-conduit
			          ./
			package *
			    ghc-options: -fexternal-interpreter -pgmi=$(command -v termux-ghc-iserv)
		EOF
	fi
}

clandro_step_post_make_install() {
	ln -sfv "$CLANDRO_PREFIX"/bin/pandoc "$CLANDRO_PREFIX"/bin/pandoc-server

	install -Dm600 ./man/*.1 -t "$CLANDRO_PREFIX"/share/man/man1/

	# Create empty completions file so that it is removed while uninstalling the package:
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/bash-completion/completions/pandoc
}

clandro_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!$CLANDRO_PREFIX/bin/sh
		pandoc --bash-completion > $CLANDRO_PREFIX/share/bash-completion/completions/pandoc
	EOF
}
