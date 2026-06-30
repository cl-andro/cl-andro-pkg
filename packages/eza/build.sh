CLANDRO_PKG_HOMEPAGE=https://github.com/eza-community/eza
CLANDRO_PKG_DESCRIPTION="A modern replacement for ls"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.23.4"
CLANDRO_PKG_SRCURL=https://github.com/eza-community/eza/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9fbcad518b8a2095206ac385329ca62d216bf9fdc652dde2d082fcb37c309635
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libgit2"
CLANDRO_PKG_BREAKS="exa"
CLANDRO_PKG_REPLACES="exa"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	local f
	for f in $CARGO_HOME/registry/src/*/libgit2-sys-*/build.rs; do
		sed -i -E 's/\.range_version\(([^)]*)\.\.[^)]*\)/.atleast_version(\1)/g' "${f}"
	done

	CFLAGS="$CPPFLAGS"
}

clandro_step_post_make_install() {
	mkdir -p $CLANDRO_PREFIX/share/man/man{1,5}
	pandoc --standalone --to man $CLANDRO_PKG_SRCDIR/man/eza.1.md --output $CLANDRO_PREFIX/share/man/man1/eza.1
	pandoc --standalone --to man $CLANDRO_PKG_SRCDIR/man/eza_colors.5.md --output $CLANDRO_PREFIX/share/man/man5/eza_colors.5
	install -Dm600 completions/bash/eza $CLANDRO_PREFIX/share/bash-completion/completions/eza
	install -Dm600 completions/fish/eza.fish $CLANDRO_PREFIX/share/fish/vendor_completions.d/eza.fish
	install -Dm600 completions/zsh/_eza $CLANDRO_PREFIX/share/zsh/site-functions/_eza
}
