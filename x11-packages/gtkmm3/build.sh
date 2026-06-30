CLANDRO_PKG_HOMEPAGE=https://www.gtkmm.org/
CLANDRO_PKG_DESCRIPTION="The C++ API for GTK"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.24.10"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gtkmm/${CLANDRO_PKG_VERSION%.*}/gtkmm-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=7ab7e2266808716e26c39924ace1fb46da86c17ef39d989624c42314b32b5a76
# Prevent updating to incompatible 4.x.x versions
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libatkmm-1.6, libc++, libcairomm-1.0, libglibmm-2.4, libpangomm-1.4, libsigc++-2.0"
CLANDRO_PKG_BUILD_DEPENDS="glib-cross, libepoxy"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dbuild-demos=false
-Dbuild-tests=false
"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}

clandro_step_post_massage() {
	local _GUARD_FILE="lib/libgtkmm-3.0.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
