CLANDRO_PKG_HOMEPAGE=https://github.com/ajeetdsouza/zoxide
CLANDRO_PKG_DESCRIPTION="A faster way to navigate your filesystem"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.9"
CLANDRO_PKG_SRCURL=https://github.com/ajeetdsouza/zoxide/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=eddc76e94db58567503a3893ecac77c572f427f3a4eabdfc762f6773abf12c63
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}

clandro_step_post_make_install() {
	install -Dm644 contrib/completions/zoxide.bash "$CLANDRO_PREFIX"/share/bash-completion/completions/zoxide
	install -Dm644 contrib/completions/_zoxide "$CLANDRO_PREFIX"/share/zsh/site-functions/_zoxide
	install -Dm644 contrib/completions/zoxide.fish "$CLANDRO_PREFIX"/share/fish/vendor_completions.d/zoxide.fish
	install -Dm644 contrib/completions/zoxide.nu "$CLANDRO_PREFIX"/share/nushell/vendor/autoload/zoxide.nu
	install -Dm644 contrib/completions/zoxide.elv "$CLANDRO_PREFIX"/share/elvish/lib/zoxide.elv
	install -Dm644 man/man1/*.1 -t "$CLANDRO_PREFIX"/share/man/man1/
}
