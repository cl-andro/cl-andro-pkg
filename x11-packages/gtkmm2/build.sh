CLANDRO_PKG_HOMEPAGE=https://www.gtkmm.org/
CLANDRO_PKG_DESCRIPTION="The C++ API for GTK"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
_MAJOR_VERSION=2.24
CLANDRO_PKG_VERSION=${_MAJOR_VERSION}.5
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/gtkmm/${_MAJOR_VERSION}/gtkmm-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=0680a53b7bf90b4e4bf444d1d89e6df41c777e0bacc96e9c09fc4dd2f5fe6b72
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk2, libatkmm-1.6, libc++, libcairomm-1.0, libglibmm-2.4, libpangomm-1.4, libsigc++-2.0"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-documentation
"

clandro_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}

clandro_step_post_massage() {
	local _GUARD_FILE="lib/libgtkmm-2.4.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
