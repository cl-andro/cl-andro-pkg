CLANDRO_PKG_HOMEPAGE=https://gitlab.com/DavidGriffith/frotz
CLANDRO_PKG_DESCRIPTION="Interpreter for Infocom and other Z-machine interactive fiction (IF) games"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# frotz does not depend on dialog or curl, but the zgames script we bundle below in clandro_step_make_install() do.
CLANDRO_PKG_VERSION="2.55"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://gitlab.com/DavidGriffith/frotz/-/archive/${CLANDRO_PKG_VERSION}/frotz-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=766d6ee97692e93d04bed755494292ff625fb53d165982c60dbbc7275cbbc6e0
CLANDRO_PKG_DEPENDS="ncurses, dialog, curl"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_GROUPS="games"

clandro_step_pre_configure () {
	export CURSES_CFLAGS="-I$CLANDRO_PREFIX/include"
	export SYSCONFDIR="$CLANDRO_PREFIX/include"
	export SOUND_TYPE="none"
}

clandro_step_post_make_install () {
	install -m755 $CLANDRO_PKG_BUILDER_DIR/zgames $CLANDRO_PREFIX/bin/zgames
}
