CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/libhandy/
CLANDRO_PKG_DESCRIPTION="Building blocks for modern adaptive GNOME apps"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
_MAJOR_VERSION=1.8
CLANDRO_PKG_VERSION=${_MAJOR_VERSION}.3
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/libhandy/${_MAJOR_VERSION}/libhandy-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=05b497229073ff557f10b326e074c5066f8743a302d4820ab97bcb5cd2dab087
CLANDRO_PKG_DEPENDS="atk, fribidi, gdk-pixbuf, glib, gtk3, libcairo, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, valac"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
-Dvapi=true
-Dtests=false
-Dexamples=false
-Dglade_catalog=disabled
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
