CLANDRO_PKG_HOMEPAGE=https://www.gtkmm.org/
CLANDRO_PKG_DESCRIPTION="A C++ API for parts of glib that are useful for C++"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.66.8"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/glibmm/${CLANDRO_PKG_VERSION%.*}/glibmm-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=64f11d3b95a24e2a8d4166ecff518730f79ecc27222ef41faf7c7e0340fc9329
CLANDRO_PKG_DEPENDS="glib, libc++, libsigc++-2.0"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dbuild-examples=false
"

clandro_step_post_massage() {
	local _GUARD_FILE="lib/${CLANDRO_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
