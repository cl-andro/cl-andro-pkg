CLANDRO_PKG_HOMEPAGE=https://github.com/seehuhn/moon-buggy
CLANDRO_PKG_DESCRIPTION="Simple game where you drive a car across the moon's surface"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_VERSION=1.0.51
CLANDRO_PKG_REVISION=6
# Main site down 2017-01-06.
# CLANDRO_PKG_SRCURL=http://m.seehuhn.de/programs/moon-buggy-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SRCURL=ftp://ftp.netbsd.org/pub/pkgsrc/distfiles/moon-buggy-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=352dc16ccae4c66f1e87ab071e6a4ebeb94ff4e4f744ce1b12a769d02fe5d23f
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--sharedstatedir=$CLANDRO_PREFIX/var"
CLANDRO_PKG_GROUPS="games"

clandro_step_make_install () {
	mkdir -p $CLANDRO_PREFIX/share/man/man6
	cp moon-buggy $CLANDRO_PREFIX/bin
	cp moon-buggy.6 $CLANDRO_PREFIX/share/man/man6
}
