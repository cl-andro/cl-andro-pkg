CLANDRO_PKG_HOMEPAGE=https://github.com/MilesCranmer/rip2
CLANDRO_PKG_DESCRIPTION="A safe and ergonomic alternative to rm"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.9.6"
CLANDRO_PKG_SRCURL="https://github.com/MilesCranmer/rip2/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=657ded2ee364e0d548697c0de28ae4e8d9564c0b5c63fd16b6718edba9a33554
CLANDRO_PKG_BREAKS="rip"
CLANDRO_PKG_REPLACES="rip"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs "$CLANDRO_PKG_MAKE_PROCESSES" --target "$CARGO_TARGET_NAME" --release
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" "target/${CARGO_TARGET_NAME}/release/rip"

	# shell completions
	mkdir -p "${CLANDRO_PREFIX}/share/zsh/site-functions"
	mkdir -p "${CLANDRO_PREFIX}/share/bash-completion/completions"
	mkdir -p "${CLANDRO_PREFIX}/share/fish/vendor_completions.d"
	mkdir -p "${CLANDRO_PREFIX}/share/elvish/lib"
	mkdir -p "${CLANDRO_PREFIX}/share/nushell/vendor/autoload"
	cargo run -- completions    zsh > "${CLANDRO_PREFIX}/share/zsh/site-functions/_${CLANDRO_PKG_NAME}"
	cargo run -- completions   bash > "${CLANDRO_PREFIX}/share/bash-completion/completions/${CLANDRO_PKG_NAME}"
	cargo run -- completions   fish > "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/${CLANDRO_PKG_NAME}.fish"
	cargo run -- completions elvish > "${CLANDRO_PREFIX}/share/elvish/lib/${CLANDRO_PKG_NAME}.elv"
	cargo run -- completions     nu > "${CLANDRO_PREFIX}/share/nushell/vendor/autoload/${CLANDRO_PKG_NAME}.nu"
}
