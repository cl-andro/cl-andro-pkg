CLANDRO_PKG_HOMEPAGE=https://www.dechifro.org/dcraw/
CLANDRO_PKG_DESCRIPTION="Raw digital camera images decoding utility"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=9.28.0
CLANDRO_PKG_REVISION=7
CLANDRO_PKG_SRCURL=https://mirrors.dotsrc.org/pub/mirrors/exherbo/dcraw-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2890c3da2642cd44c5f3bfed2c9b2c1db83da5cec09cc17e0fa72e17541fb4b9
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="littlecms, libjasper, libjpeg-turbo"

clandro_step_make_install() {
	# See the "install" script for flags:
	$CC $CFLAGS $CPPFLAGS $LDFLAGS dcraw.c -lm -ljasper -ljpeg -llcms2 -o $CLANDRO_PREFIX/bin/dcraw
	chmod +w dcraw.1 # Add missing write permission
	cp dcraw.1 $CLANDRO_PREFIX/share/man/man1/
}
