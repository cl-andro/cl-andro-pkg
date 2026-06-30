CLANDRO_PKG_HOMEPAGE=https://just.systems
CLANDRO_PKG_DESCRIPTION="A handy way to save and run project-specific commands"
CLANDRO_PKG_LICENSE="CC0-1.0"
CLANDRO_PKG_MAINTAINER="@flipee"
CLANDRO_PKG_VERSION="1.50.0"
CLANDRO_PKG_SRCURL=https://github.com/casey/just/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=cca015e07739a1c26c6fc459f7d46e1e36ce0f7613114eddedd8cd3af55a10b7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_post_configure() {
	# clash with rust host build
	# causes 32bit builds to fail if set
	unset CFLAGS
}

clandro_step_post_make_install() {
	mkdir -p "${CLANDRO_PREFIX}/share/man/man1"
	mkdir -p "${CLANDRO_PREFIX}/share/zsh/site-functions"
	mkdir -p "${CLANDRO_PREFIX}/share/bash-completion/completions"
	mkdir -p "${CLANDRO_PREFIX}/share/fish/vendor_completions.d"
	mkdir -p "${CLANDRO_PREFIX}/share/elvish/lib"
	cargo run -- --man | gzip -c -f -n > "${CLANDRO_PREFIX}/share/man/man1/just.1.gz"
	cargo run -- --completions    zsh > "${CLANDRO_PREFIX}/share/zsh/site-functions/_just"
	cargo run -- --completions   bash > "${CLANDRO_PREFIX}/share/bash-completion/completions/just"
	cargo run -- --completions   fish > "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/just.fish"
	cargo run -- --completions elvish > "${CLANDRO_PREFIX}/share/elvish/lib/just.elv"

	# Move the `just` binary to $PREFIX/libexec
	# and replace it with our --ceiling shim.
	# See: packages/just/just-shim.sh for details.
	mkdir -p "$CLANDRO_PREFIX/libexec/just"
	mv "${CLANDRO_PREFIX}"/bin/just "${CLANDRO_PREFIX}"/libexec/just
	sed \
		-e "s|@CLANDRO_PREFIX@|${CLANDRO_PREFIX}|g" \
		-e "s|@CLANDRO_HOME@|${CLANDRO_ANDROID_HOME}|g" \
		"$CLANDRO_PKG_BUILDER_DIR/just-shim.sh" \
		> "${CLANDRO_PREFIX}/bin/just"
	chmod 700 "${CLANDRO_PREFIX}/bin/just"
}
