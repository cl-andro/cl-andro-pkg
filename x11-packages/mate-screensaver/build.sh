CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="Screensaver for MATE"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.0"
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/mate-screensaver/releases/download/v$CLANDRO_PKG_VERSION/mate-screensaver-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=6a0f24a8f84a2f95e10114ab53e63fd4aca688a55fdc503ed650e0a410e3ea70
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="mate-panel, libmatekbd, gettext, libnotify, libxss, mate-desktop, mate-menus, mate-session-manager"
CLANDRO_PKG_BUILD_DEPENDS="autoconf-archive, glib, mate-common"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--sysconfdir=$CLANDRO_PREFIX/etc
--with-mit-ext
--with-libnotify
--disable-locking
--without-console-kit
"
