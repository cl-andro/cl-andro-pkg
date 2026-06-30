CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/libdazzle
CLANDRO_PKG_DESCRIPTION="A companion library to GObject and Gtk+"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.44.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/libdazzle/${CLANDRO_PKG_VERSION%.*}/libdazzle-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=3cd3e45eb6e2680cb05d52e1e80dd8f9d59d4765212f0e28f78e6c1783d18eae
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libcairo, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, valac"
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Denable_tools=false
-Dwith_introspection=true
-Dwith_vapi=true
-Denable_tests=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
