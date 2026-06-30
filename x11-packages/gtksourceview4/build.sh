CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/GtkSourceView
CLANDRO_PKG_DESCRIPTION="A GNOME library that extends GtkTextView"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.8.4"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gtksourceview/${CLANDRO_PKG_VERSION%.*}/gtksourceview-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=7ec9d18fb283d1f84a3a3eff3b7a72b09a10c9c006597b3fbabbb5958420a87d
CLANDRO_PKG_DEPENDS="atk, fribidi, gdk-pixbuf, glib, gtk3, libcairo, libxml2, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, valac"
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dgir=true
-Dvapi=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}

clandro_step_post_massage() {
	local _GUARD_FILE="lib/libgtksourceview-4.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
