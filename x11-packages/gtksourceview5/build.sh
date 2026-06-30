CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/GtkSourceView
CLANDRO_PKG_DESCRIPTION="A GNOME library that extends GtkTextView"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.20.0"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gtksourceview/${CLANDRO_PKG_VERSION%.*}/gtksourceview-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=e38bcd23f52b86eadf0fe4d8bde698e3a8ca102322b8b4cf1a51ac294a448c1b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fontconfig, fribidi, gdk-pixbuf, glib, gtk4, libcairo, libxml2, pango, pcre2"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, valac"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dbuild-testsuite=false
-Ddocumentation=false
-Dintrospection=enabled
-Dvapi=true
"

clandro_step_pre_configure() {
	# Workaround strict compiler error
	sed -i "s/-Werror/-Wno-error/g" meson.build

	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}

clandro_step_post_massage() {
	local _GUARD_FILE="lib/libgtksourceview-5.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
