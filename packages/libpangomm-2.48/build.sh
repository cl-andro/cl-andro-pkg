CLANDRO_PKG_HOMEPAGE=https://www.gtkmm.org/
CLANDRO_PKG_DESCRIPTION="A C++ API for Pango"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.56.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/pangomm/${CLANDRO_PKG_VERSION%.*}/pangomm-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=539f5aa60e9bdc6b955bb448e2a62cc14562744df690258040fbb74bf885755d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, libc++, libcairomm-1.16, libglibmm-2.68, libsigc++-3.0, pango"

clandro_step_post_massage() {
	local _GUARD_FILE="lib/${CLANDRO_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
