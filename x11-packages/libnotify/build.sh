CLANDRO_PKG_HOMEPAGE=https://developer.gnome.org/notification-spec/
CLANDRO_PKG_DESCRIPTION="Library for sending desktop notifications"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.8"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/libnotify/${CLANDRO_PKG_VERSION%.*}/libnotify-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=23420ef619dc2cb5aebad613f4823a2fa41c07e5a1d05628d40f6ec4b35bfddd
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dtests=false
-Dintrospection=enabled
-Dgtk_doc=false"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]; then
		# Pre-installed headers affect GIR generation:
		rm -rf "$CLANDRO_PREFIX/include/libnotify"
	fi
}
