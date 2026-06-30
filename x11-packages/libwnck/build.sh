CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/libwnck
CLANDRO_PKG_DESCRIPTION="Window Navigator Construction Kit"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="43.3"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/libwnck/${CLANDRO_PKG_VERSION%.*}/libwnck-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=6af8ac41a8f067ade1d3caaed254a83423b5f61ad3f7a460fcacbac2e192bdf7
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, libcairo, libx11, libxrender, pango, startup-notification"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_RM_AFTER_INSTALL="lib/locale"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
