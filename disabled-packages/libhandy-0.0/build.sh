CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/libhandy/
CLANDRO_PKG_DESCRIPTION="Building blocks for modern adaptive GNOME apps"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.0.13"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://deb.debian.org/debian/pool/main/libh/libhandy/libhandy_${CLANDRO_PKG_VERSION}.orig.tar.gz
CLANDRO_PKG_SHA256=4dcd9d249558834bd5430445d3674e9e3cff356e35f0c1dd368c3af50fa15b6d
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, libcairo, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, valac"
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

clandro_step_post_massage() {
	local _GUARD_FILE="lib/${CLANDRO_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
