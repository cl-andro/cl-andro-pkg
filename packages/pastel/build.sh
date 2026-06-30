CLANDRO_PKG_HOMEPAGE=https://github.com/sharkdp/pastel
CLANDRO_PKG_DESCRIPTION="A command-line tool to generate, analyze, convert and manipulate colors"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE-MIT, LICENSE-APACHE"
CLANDRO_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.12.0"
CLANDRO_PKG_SRCURL=https://github.com/sharkdp/pastel/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2903853f24d742fe955edd9bea17947eb8f3f44000a8ac528d16f2ea1e52b78b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_make() {
	SHELL_COMPLETIONS_DIR=$CLANDRO_PKG_BUILDDIR/completions cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/pastel

	# Install completions
	install -Dm600 $CLANDRO_PKG_BUILDDIR/completions/_pastel \
		$CLANDRO_PREFIX/share/zsh/site-functions/_pastel
	install -Dm600 $CLANDRO_PKG_BUILDDIR/completions/pastel.bash \
		$CLANDRO_PREFIX/share/bash-completion/completions/pastel.bash
	install -Dm600 $CLANDRO_PKG_BUILDDIR/completions/pastel.fish \
		$CLANDRO_PREFIX/share/fish/vendor_completions.d/pastel.fish
}
