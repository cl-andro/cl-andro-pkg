CLANDRO_PKG_HOMEPAGE=https://lastpass.com/
CLANDRO_PKG_DESCRIPTION="LastPass command line interface tool"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.6.1"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/lastpass/lastpass-cli/archive/refs/tags/v$CLANDRO_PKG_VERSION/lastpass-cli-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=9989ef0650db18bc3f80ba52964202b778abda0548f95dcd321e9c7c39a1a24e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libcurl, libxml2, openssl, pinentry"
CLANDRO_PKG_BUILD_DEPENDS="bash-completion"
CLANDRO_PKG_SUGGESTS="clandro-api"

clandro_step_post_make_install() {
	ninja install-doc

	install -Dm600 "$CLANDRO_PKG_SRCDIR"/contrib/lpass_zsh_completion \
		"$CLANDRO_PREFIX"/share/zsh/site-functions/_lpass

	install -Dm600 "$CLANDRO_PKG_SRCDIR"/contrib/completions-lpass.fish \
		"$CLANDRO_PREFIX"/share/fish/vendor_completions.d/lpass.fish
}
