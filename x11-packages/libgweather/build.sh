CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/libgweather
CLANDRO_PKG_DESCRIPTION="Location and timezone database and weather-lookup library"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.5.0"
CLANDRO_PKG_SRCURL="https://download.gnome.org/sources/libgweather/${CLANDRO_PKG_VERSION%.*}/libgweather-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=e464c1aebe8117c8a170206d7baefe730393b7e98044c2cd97b3aa8604ef12aa
CLANDRO_PKG_DEPENDS="geocode-glib, glib, gobject-introspection, gweather-locations, json-glib, libsoup3, libxml2"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=true
-Dgtk_doc=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper

	export CLANDRO_MESON_ENABLE_SOVERSION=1
}
