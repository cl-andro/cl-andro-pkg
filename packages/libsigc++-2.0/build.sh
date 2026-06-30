CLANDRO_PKG_HOMEPAGE=https://libsigcplusplus.github.io/libsigcplusplus/
CLANDRO_PKG_DESCRIPTION="Implements a typesafe callback system for standard C++"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.12.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/libsigc++/${CLANDRO_PKG_VERSION%.*}/libsigc++-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=a9dbee323351d109b7aee074a9cb89ca3e7bcf8ad8edef1851f4cf359bd50843
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dbuild-examples=false
-Dbuild-tests=false
"

clandro_step_post_massage() {
	local _GUARD_FILE="lib/${CLANDRO_PKG_NAME/++/}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
