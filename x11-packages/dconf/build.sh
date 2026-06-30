CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/dconf
CLANDRO_PKG_DESCRIPTION="dconf is a simple key/value storage system that is heavily optimised for reading"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.49.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/dconf/${CLANDRO_PKG_VERSION%.*}/dconf-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=16a47e49a58156dbb96578e1708325299e4c19eea9be128d5bd12fd0963d6c36
CLANDRO_PKG_DEPENDS="dbus, glib"
CLANDRO_PKG_BUILD_DEPENDS="glib-cross, valac"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dbash_completion=false
"
CLANDRO_PKG_RM_AFTER_INSTALL="
lib/systemd
"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
