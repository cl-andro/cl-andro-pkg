CLANDRO_PKG_HOMEPAGE=https://www.gtkmm.org/
CLANDRO_PKG_DESCRIPTION="The C++ binding for the ATK library"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.28.4
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/atkmm/${CLANDRO_PKG_VERSION%.*}/atkmm-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=0a142a8128f83c001efb8014ee463e9a766054ef84686af953135e04d28fdab3
CLANDRO_PKG_DEPENDS="atk, glib, libc++, libglibmm-2.4, libsigc++-2.0"

clandro_step_post_massage() {
	local _GUARD_FILE="lib/${CLANDRO_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
