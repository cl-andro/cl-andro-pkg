CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/Archive/libgnomekbd
CLANDRO_PKG_DESCRIPTION="GNOME keyboard library"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.28.1"
CLANDRO_PKG_SRCURL="https://download.gnome.org/sources/libgnomekbd/${CLANDRO_PKG_VERSION%.*}/libgnomekbd-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=22dc59566d73c0065350f5a97340e62ecc7b08c4df19183804bb8be24c8fe870
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, gobject-introspection, libxml2, libxklavier, gigolo, libx11"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, valac"
CLANDRO_PKG_DISABLE_GIR=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dtests=false
-Dvapi=false
-Dintrospection=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	export CLANDRO_MESON_ENABLE_SOVERSION=1
}
