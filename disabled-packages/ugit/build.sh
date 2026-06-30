CLANDRO_PKG_HOMEPAGE=https://github.com/Bhupesh-V/ugit
CLANDRO_PKG_DESCRIPTION="ugit helps you undo your last git command with grace. Your damage control git buddy"
CLANDRO_PKG_LICENSE=MIT
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.9"
CLANDRO_PKG_SRCURL=$CLANDRO_PKG_HOMEPAGE/archive/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=f93d9d4bb0d6fd676704e45733190413885c859ff2807b84cc8113bf674fc063
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS='bash, fzf, ncurses-utils'
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_make_install() {
	local bin="$(basename $CLANDRO_PKG_HOMEPAGE)"
	install -D "$bin" -t "$CLANDRO_PREFIX/bin"
	ln -sf "$CLANDRO_PREFIX/bin/$bin"  "$CLANDRO_PREFIX/bin/gitundo"
}
