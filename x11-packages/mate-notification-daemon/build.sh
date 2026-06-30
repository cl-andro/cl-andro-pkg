CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="Notification daemon for MATE"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.5"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/mate-notification-daemon/releases/download/v$CLANDRO_PKG_VERSION/mate-notification-daemon-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=d3090ea9d1a859e2def9c4d2319f9ac96a79b7a33598a97784db40be2508f668
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libcanberra, libwnck, libnotify, gettext, mate-panel"
CLANDRO_PKG_BUILD_DEPENDS="autoconf-archive, glib, mate-common, python"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--sysconfdir=$CLANDRO_PREFIX/etc
"
