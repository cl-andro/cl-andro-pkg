CLANDRO_PKG_HOMEPAGE=https://libsigcplusplus.github.io/libsigcplusplus/
CLANDRO_PKG_DESCRIPTION="Implements a typesafe callback system for standard C++"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.6.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/libsigc++/${CLANDRO_PKG_VERSION%.*}/libsigc++-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=c3d23b37dfd6e39f2e09f091b77b1541fbfa17c4f0b6bf5c89baef7229080e17
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dbuild-examples=false
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_post_massage() {
	local _GUARD_FILE="lib/${CLANDRO_PKG_NAME/++/}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
