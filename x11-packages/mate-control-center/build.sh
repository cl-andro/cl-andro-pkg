CLANDRO_PKG_HOMEPAGE=https://mate-desktop.org/
CLANDRO_PKG_DESCRIPTION="Utilities to configure the MATE desktop"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.1"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/mate-control-center/releases/download/v$CLANDRO_PKG_VERSION/mate-control-center-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=e12d34c1c1f11e3d0a2ba2dd41bc1c997bf0d1d56486896756f6edaac5f9a9b2
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="dconf, mate-menus, mate-settings-daemon, marco, libgtop, libxss, mate-desktop, gettext, mate-panel, libcanberra, libayatana-appindicator"
CLANDRO_PKG_BUILD_DEPENDS="autoconf-archive, glib, mate-common"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--sysconfdir=$CLANDRO_PREFIX/etc
--localstatedir=$CLANDRO_PREFIX/var
--disable-update-mimedb
--disable-systemd
"

clandro_step_pre_configure() {
	autoreconf -fi
}
