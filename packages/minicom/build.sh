CLANDRO_PKG_HOMEPAGE=https://salsa.debian.org/minicom-team/minicom
CLANDRO_PKG_DESCRIPTION="Friendly menu driven serial communication program"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.11.1"
CLANDRO_PKG_SRCURL="https://salsa.debian.org/minicom-team/minicom/-/archive/${CLANDRO_PKG_VERSION}/minicom-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=b296b0e5795ca143fb1ffa78f46fd294daddfccd720faf9909a842d2f70c564e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP='^[\d.]+$'
CLANDRO_PKG_DEPENDS="libiconv, ncurses"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-socket
--disable-music
--enable-lock-dir=$CLANDRO_PREFIX/var/run
"

clandro_step_pre_configure() {
	export CFLAGS+=" -fcommon"
	CPPFLAGS+=" -Dushort=u_short"
}
