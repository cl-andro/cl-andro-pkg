CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="Process viewer and system resource monitor for MATE"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.1"
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/mate-system-monitor/releases/download/v$CLANDRO_PKG_VERSION/mate-system-monitor-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=42d663d6b90fb5361ebc13f6547983d6f1e2ac75dc2ae4f1cac6ea6329965a25
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gettext, glib, gtkmm3, libgtop, libsm, librsvg"
CLANDRO_PKG_BUILD_DEPENDS="autoconf-archive, mate-common"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-systemd
"
