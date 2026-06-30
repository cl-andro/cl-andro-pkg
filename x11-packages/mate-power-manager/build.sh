CLANDRO_PKG_HOMEPAGE="https://mate-desktop.org/"
CLANDRO_PKG_DESCRIPTION="Power management tool for the MATE desktop"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.1"
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/mate-power-manager/releases/download/v$CLANDRO_PKG_VERSION/mate-power-manager-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256="8ebdcb74b607e868336ba9a8146cdef8f97bce535c2b0cb3bf650c58f71eee21"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="dbus-glib, gettext, libc++, libcanberra, libnotify, libsecret, upower"
CLANDRO_PKG_BUILD_DEPENDS="autoconf-archive, glib, mate-common, mate-panel"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Denable-tests=false
"

clandro_step_pre_configure() {
	rm -f configure
	clandro_setup_glib_cross_pkg_config_wrapper
}
