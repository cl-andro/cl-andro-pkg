CLANDRO_PKG_HOMEPAGE=https://rephial.org/
CLANDRO_PKG_DESCRIPTION="Dungeon exploration adventure game"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.2.6"
CLANDRO_PKG_SHA256=64091eb98e1b08c4d69a9ca94802ea797aef09daaaf335e450bc64f80ee56911
CLANDRO_PKG_SRCURL=https://github.com/angband/angband/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-x11
--bindir=$CLANDRO_PREFIX/bin
--sysconfdir=$CLANDRO_PREFIX/share/angband
"
CLANDRO_PKG_RM_AFTER_INSTALL="
share/angband/fonts
share/angband/icons
share/angband/sounds
share/angband/xtra
"
CLANDRO_PKG_GROUPS="games"

clandro_step_pre_configure () {
	./autogen.sh
	perl -p -i -e 's|ncursesw5-config|ncursesw6-config|g' configure
}
