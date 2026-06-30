CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Apps/Ghex
CLANDRO_PKG_DESCRIPTION="A simple binary editor for the Gnome desktop."
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="50.0"
CLANDRO_PKG_SRCURL=https://gitlab.gnome.org/GNOME/ghex/-/archive/${CLANDRO_PKG_VERSION}/ghex-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=692bd5f7007e6c422562674bfd7b04fb3a3715dbcae297165368918af9e613fd
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, gtk4, libadwaita, libcairo, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, valac"
CLANDRO_PKG_RECOMMENDS="ghex-help"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dgtk_doc=false
-Dintrospection=enabled
-Dvapi=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
