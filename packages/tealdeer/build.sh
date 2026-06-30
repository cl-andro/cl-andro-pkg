CLANDRO_PKG_HOMEPAGE=https://tealdeer-rs.github.io/tealdeer/
CLANDRO_PKG_DESCRIPTION="A very fast implementation of tldr in Rust"
CLANDRO_PKG_LICENSE="Apache-2.0, MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.8.1"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_SRCURL=https://github.com/tealdeer-rs/tealdeer/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8b9ea7ef8dd594d6fb8b452733b0c883a68153cec266b23564ce185bdf22fcfa
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/tldr

	install -Dm644 completion/zsh_tealdeer "$CLANDRO_PREFIX/share/zsh/site-functions/_tldr"
	install -Dm644 completion/bash_tealdeer "$CLANDRO_PREFIX/share/bash-completion/completions/tldr"
	install -Dm644 completion/fish_tealdeer "$CLANDRO_PREFIX/share/fish/vendor_completions.d/tldr.fish"
}
