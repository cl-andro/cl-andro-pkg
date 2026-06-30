CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/gnome-desktop
CLANDRO_PKG_DESCRIPTION="Utility library for loading .desktop files"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="44.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gnome-desktop/${CLANDRO_PKG_VERSION%.*}/gnome-desktop-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=40efa9aa8d50effed9227a3d70671e32e9dc35e20f331cab3b562975978f4f8d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gsettings-desktop-schemas, gtk4, iso-codes, libcairo, libxkbcommon, xkeyboard-config"
CLANDRO_PKG_BUILD_DEPENDS="fontconfig, g-ir-scanner, glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Ddesktop_docs=false
-Ddebug_tools=false
-Dintrospection=true
-Dbuild_gtk4=true
-Dlegacy_library=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}

clandro_step_post_massage() {
	local _GUARD_FILE="lib/libgnome-desktop-4.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
