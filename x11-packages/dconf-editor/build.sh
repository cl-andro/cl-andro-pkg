CLANDRO_PKG_HOMEPAGE=https://apps.gnome.org/DconfEditor
CLANDRO_PKG_DESCRIPTION="A GSettings editor for GNOME"
CLANDRO_PKG_LICENSE="GPL-3.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="49.0"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/dconf-editor/${CLANDRO_PKG_VERSION%%.*}/dconf-editor-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=90a8ccfadf51dff31e0028324fb9a358b2d26c5ae861a71c7dbf9f4dd9bdd399
CLANDRO_PKG_DEPENDS="dbus, glib, libhandy, dconf"
CLANDRO_PKG_BUILD_DEPENDS="glib-cross, valac, gettext, libhandy, dconf"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
