CLANDRO_PKG_HOMEPAGE=https://www.gtkmm.org/
CLANDRO_PKG_DESCRIPTION="The C++ API for GTK"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.22.0"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gtkmm/${CLANDRO_PKG_VERSION%.*}/gtkmm-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=2e8a21b4b0725f620e33aaee0cd343ed121b533275b632896619b1c89e96de67
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, graphene, gtk4, libc++, libcairo, libcairomm-1.16, libglibmm-2.68, libpangomm-2.48, libsigc++-3.0"
CLANDRO_PKG_BUILD_DEPENDS="libepoxy"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dbuild-demos=false
-Dbuild-tests=false
"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}

clandro_step_post_massage() {
	local _GUARD_FILE="lib/libgtkmm-4.0.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
