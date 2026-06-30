CLANDRO_PKG_HOMEPAGE=https://yadm.io/
CLANDRO_PKG_DESCRIPTION="Yet Another Dotfiles Manager"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.5.0"
CLANDRO_PKG_SRCURL=https://github.com/yadm-dev/yadm/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2a15ed91238dd2f15db9905eb56702272c079ad9c37c505dfee69c6b5e9054b6
CLANDRO_PKG_DEPENDS="git"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_make() {
	# Do not try to run 'make' as it causes a build failure.
	return
}

clandro_step_make_install() {
	install -Dm700 "$CLANDRO_PKG_SRCDIR"/yadm "$CLANDRO_PREFIX"/bin/
	install -Dm600 "$CLANDRO_PKG_SRCDIR"/yadm.1 "$CLANDRO_PREFIX"/share/man/man1/
	install -Dm600 "$CLANDRO_PKG_SRCDIR"/completion/bash/yadm \
		"$CLANDRO_PREFIX"/share/bash-completion/completions/yadm
	install -Dm600 "$CLANDRO_PKG_SRCDIR"/completion/zsh/_yadm \
		"$CLANDRO_PREFIX"/share/zsh/site-functions/_yadm
	install -Dm600 "$CLANDRO_PKG_SRCDIR"/completion/fish/yadm.fish \
		"$CLANDRO_PREFIX"/share/fish/vendor_completions.d/yadm.fish
}
