CLANDRO_PKG_HOMEPAGE=https://github.com/Aanok/jftui
CLANDRO_PKG_DESCRIPTION="jftui is a minimalistic, lightweight C99 command line client for the open source Jellyfin media server."
CLANDRO_PKG_LICENSE="Unlicense"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.7.5"
CLANDRO_PKG_SRCURL=https://github.com/Aanok/jftui/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1e9a8a7a76d54510381fa0746245a0a3a392673ef592a4efed478775c402cec9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libcurl, yajl, mpv"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	sed -i 's| -march=native||' Makefile
	sed -i 's|^CFLAGS=|override CFLAGS+=|' Makefile
	sed -i 's|^LFLAGS=|override LFLAGS+=|' Makefile
}

clandro_step_make() {
	make CFLAGS="$CPPFLAGS" LFLAGS="$LDFLAGS"
}

clandro_step_make_install() {
	install -Dm700 $CLANDRO_PKG_SRCDIR/build/jftui "$CLANDRO_PREFIX/bin/jftui"
}
