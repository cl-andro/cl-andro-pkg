CLANDRO_PKG_HOMEPAGE=http://www.irc.org/
CLANDRO_PKG_DESCRIPTION="An Internet Relay Chat (IRC) daemon"
CLANDRO_PKG_LICENSE="GPL-2.0" # GPL-1.0-or-later
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.11.2p3
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=http://www.irc.org/ftp/irc/server/irc${CLANDRO_PKG_VERSION}.tgz
CLANDRO_PKG_SHA256=be94051845f9be7da0e558699c4af7963af7e647745d339351985a697eca2c81
CLANDRO_PKG_DEPENDS="libcrypt, resolv-conf"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$CLANDRO_PREFIX/share/man
--with-resconf=$CLANDRO_PREFIX/etc/resolv.conf
ac_cv_func_setpgrp_void=yes
irc_cv_non_blocking_system=posix
"
CLANDRO_PKG_EXTRA_MAKE_ARGS="-C build"

clandro_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -lcrypt"
}
