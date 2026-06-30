CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/boinctui/
CLANDRO_PKG_DESCRIPTION="curses based manager for Boinc client"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.7.2"
CLANDRO_PKG_SRCURL="https://sourceforge.net/projects/boinctui/files/boinctui_${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=6e2ca56e95c321f55e032a539e63dce37298d96b73e8f809101569c41e73ee11
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, libc++, libexpat, ncurses, ncurses-ui-libs, openssl"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--without-gnutls --mandir=${CLANDRO_PREFIX}/share/man"

clandro_step_pre_configure() {
	export CFLAGS+=" -flto"
	export CXXFLAGS+=" -flto"
	autoreconf -fi
}
