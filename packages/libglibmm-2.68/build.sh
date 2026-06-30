CLANDRO_PKG_HOMEPAGE=https://www.gtkmm.org/
CLANDRO_PKG_DESCRIPTION="A C++ API for parts of glib that are useful for C++"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.88.0"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/glibmm/${CLANDRO_PKG_VERSION%.*}/glibmm-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=a6549da3a6c43de83b8717dae5413c57a60d92f6ecc624615c612d0bb0ad0fe2
CLANDRO_PKG_DEPENDS="glib, libc++, libsigc++-3.0"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dbuild-examples=false
"

clandro_step_post_massage() {
	local _GUARD_FILE="lib/${CLANDRO_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
