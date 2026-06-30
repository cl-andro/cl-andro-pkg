CLANDRO_PKG_HOMEPAGE=https://github.com/zsh-users/zsh-completions
CLANDRO_PKG_DESCRIPTION="Additional completion definitions for Zsh"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.36.0"
CLANDRO_PKG_SRCURL=https://github.com/zsh-users/zsh-completions/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=5aa68be2999a7be2eb56de8e4acff8f3bba4a66b9acbb233752536857408fb2e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS=zsh
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	install -Dm644 src/* -t "$CLANDRO_PREFIX/share/zsh/site-functions"
}
