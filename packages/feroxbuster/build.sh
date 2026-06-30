CLANDRO_PKG_HOMEPAGE="https://github.com/epi052/feroxbuster"
CLANDRO_PKG_DESCRIPTION="A fast, simple, recursive content discovery tool written in Rust"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.13.1"
CLANDRO_PKG_SRCURL="https://github.com/epi052/feroxbuster/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=6f1f3466319ea5485b9d6f05000718c6ccbe1210c1cea7b2af83a5343d068a23
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="openssl"

clandro_step_post_get_source() {
	sed -i -E '/^openssl\s*=/s/(,\s*)?"vendored"//g' Cargo.toml
}

clandro_step_pre_configure() {
	clandro_setup_rust

	rm -f Makefile
}

clandro_step_post_make_install() {
	# shell completions
	install -Dm644 "$CLANDRO_PKG_SRCDIR/shell_completions/feroxbuster.bash" \
		"$CLANDRO_PREFIX"/share/bash-completion/completions/feroxbuster
	install -Dm644 "$CLANDRO_PKG_SRCDIR/shell_completions/_feroxbuster" \
		"$CLANDRO_PREFIX"/share/zsh/site-functions/_feroxbuster
	install -Dm644 "$CLANDRO_PKG_SRCDIR/shell_completions/feroxbuster.fish" \
		"$CLANDRO_PREFIX"/share/fish/vendor_completions.d/feroxbuster.fish
}
