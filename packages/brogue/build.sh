CLANDRO_PKG_HOMEPAGE=https://sites.google.com/site/broguegame/
CLANDRO_PKG_DESCRIPTION="Roguelike dungeon crawling game (community edition)"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.15.1"
CLANDRO_PKG_SRCURL=https://github.com/tmewett/BrogueCE/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2abc186c5327342cb9ad7e45d41096ab10797d5ba76dcac843824ac2a0bfb3ac
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_GROUPS="games"

clandro_step_pre_configure () {
	CFLAGS+=" -fcommon"
	CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS"
}

clandro_step_make_install () {
	install -m700 bin/brogue $CLANDRO_PREFIX/bin
}
