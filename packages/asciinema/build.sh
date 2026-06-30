CLANDRO_PKG_HOMEPAGE=https://asciinema.org/
CLANDRO_PKG_DESCRIPTION="Record and share your terminal sessions, the right way"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:3.2.0"
: "${CLANDRO_PKG_VERSION:2}" # We need to remove both the epoch and the '~' from the version
CLANDRO_PKG_SRCURL=https://github.com/asciinema/asciinema/archive/refs/tags/v${_//\~/-}.tar.gz
CLANDRO_PKG_SHA256=247c7c87481f38d7788c1fb1be12021c778676c0d0ab37e529ec528f87f487ce
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	# Clean up any previous compiler output for repeated builds.
	rm -rf "target/${CARGO_TARGET_NAME}/release/build/"asciinema-*

	clandro_setup_rust

	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" "target/${CARGO_TARGET_NAME}/release/asciinema"

	# Man pages
	install -Dm600 -t "$CLANDRO_PREFIX/share/man/man1" "target/${CARGO_TARGET_NAME}/release/build/"asciinema-*/out/man/*

	# Shell completions
	install -Dm600 -t "${CLANDRO_PREFIX}/share/bash-completion/completions" "target/${CARGO_TARGET_NAME}/release/build/"asciinema-*/out/completion/asciinema.bash
	install -Dm600 -t "${CLANDRO_PREFIX}/share/fish/vendor_completions.d" "target/${CARGO_TARGET_NAME}/release/build/"asciinema-*/out/completion/asciinema.fish
	install -Dm600 -t "${CLANDRO_PREFIX}/share/elvish/lib" "target/${CARGO_TARGET_NAME}/release/build/"asciinema-*/out/completion/asciinema.elv
	install -Dm600 -t "${CLANDRO_PREFIX}/share/zsh/site-functions" "target/${CARGO_TARGET_NAME}/release/build/"asciinema-*/out/completion/_asciinema
}
