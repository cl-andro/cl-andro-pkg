CLANDRO_PKG_HOMEPAGE=https://www.gtkmm.org/
CLANDRO_PKG_DESCRIPTION="A C++ API for Pango"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.46.4"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/pangomm/${CLANDRO_PKG_VERSION%.*}/pangomm-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=b92016661526424de4b9377f1512f59781f41fb16c9c0267d6133ba1cd68db22
CLANDRO_PKG_DEPENDS="glib, libc++, libcairomm-1.0, libglibmm-2.4, libsigc++-2.0, pango"

clandro_step_post_massage() {
	local _GUARD_FILE="lib/${CLANDRO_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
