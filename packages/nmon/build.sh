CLANDRO_PKG_HOMEPAGE=https://nmon.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Curses based Performance Monitor for Linux with saving performance stats to a CSV file mode"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="16s"
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/nmon/lmon${CLANDRO_PKG_VERSION}.c
CLANDRO_PKG_SHA256=0736ce0f729e48c124a7ba566c069c5a234511cc9c6ac9277da92f8bb44f2b11
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_get_source() {
	clandro_download $CLANDRO_PKG_SRCURL $CLANDRO_PKG_CACHEDIR/lmon.c $CLANDRO_PKG_SHA256
	mkdir -p $CLANDRO_PKG_SRCDIR
	cp $CLANDRO_PKG_CACHEDIR/lmon.c $CLANDRO_PKG_SRCDIR
}

clandro_step_pre_configure() {
	case $CLANDRO_ARCH in
		aarch64 | arm ) CPPFLAGS+=" -DARM" ;;
		* ) CPPFLAGS+=" -DX86" ;;
	esac
}

clandro_step_make() {
	$CC $CFLAGS $CPPFLAGS $CLANDRO_PKG_SRCDIR/lmon.c -o nmon $LDFLAGS -lncurses -lm
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin nmon
}
