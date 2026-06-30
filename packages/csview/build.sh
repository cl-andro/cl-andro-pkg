CLANDRO_PKG_HOMEPAGE="https://github.com/wfxr/csview"
CLANDRO_PKG_DESCRIPTION="Pretty-printing CSV/TSV/xSV on terminal"
CLANDRO_PKG_LICENSE="MIT, Apache-2.0"
CLANDRO_PKG_LICENSE_FILE="LICENSE-MIT"
CLANDRO_PKG_MAINTAINER="@flosnvjx"
CLANDRO_PKG_VERSION="1.3.4"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_SRCURL="https://github.com/wfxr/csview/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=91fadcddef511265f4bf39897ce4a65c457ac89ffd8dd742dc209d30bf04d6aa

CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_rust
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release --locked
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/csview
	install -Dm600 -t $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME README.*
	install -Dm600 "completions/fish/csview.fish" "$CLANDRO_PREFIX/share/fish/vendor_completions.d/csview.fish"
	install -Dm600 "completions/zsh/_csview" "$CLANDRO_PREFIX/share/zsh/site-functions/_csview"
	install -Dm600 "completions/bash/csview.bash" "$CLANDRO_PREFIX/share/bash-completion/completions/csview"

	# https://github.com/elves/elvish/issues/1564#issuecomment-1166333636
	install -Dm600 "completions/elvish/csview.elv" -t $CLANDRO_PREFIX/share/elvish/lib
}
