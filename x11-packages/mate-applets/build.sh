CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="Applets for use with the MATE panel"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later, LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/mate-applets/releases/download/v$CLANDRO_PKG_VERSION/mate-applets-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=a5967141527dc5b172d322a6003c23aeec253160f650bb36430a06ddaefa7e2e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gtksourceview4, libgtop, libnotify, mate-panel, libnl, upower"
CLANDRO_PKG_SUGGESTS="fortune, gucharmap"
CLANDRO_PKG_BUILD_DEPENDS="autoconf-archive, mate-common, glib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--sysconfdir=$CLANDRO_PREFIX/etc
--with-dbus-sys=$CLANDRO_PREFIX/share/dbus-1/system.d
--disable-polkit
"
