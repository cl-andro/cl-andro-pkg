CLANDRO_PKG_HOMEPAGE=https://github.com/chmln/sd
CLANDRO_PKG_DESCRIPTION="An intuitive find & replace CLI"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.1.0"
CLANDRO_PKG_SRCURL=git+https://github.com/chmln/sd
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/sd

	install -Dm644 gen/sd.1 "$CLANDRO_PREFIX/share/man/man1/sd.1"

	install -Dm644 gen/completions/sd.bash "$CLANDRO_PREFIX/share/bash-completion/completions/sd"
	install -Dm644 gen/completions/_sd "$CLANDRO_PREFIX/share/zsh/site-functions/_sd"
	install -Dm644 gen/completions/sd.fish "$CLANDRO_PREFIX/share/fish/vendor_completions.d/sd.fish"
	install -Dm644 gen/completions/sd.elv "$CLANDRO_PREFIX/share/elvish/lib/sd.elv"
}
