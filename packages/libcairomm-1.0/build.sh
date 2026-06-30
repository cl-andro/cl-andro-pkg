CLANDRO_PKG_HOMEPAGE=https://www.cairographics.org/cairomm/
CLANDRO_PKG_DESCRIPTION="Provides a C++ interface to cairo"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.14.5"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://www.cairographics.org/releases/cairomm-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=70136203540c884e89ce1c9edfb6369b9953937f6cd596d97c78c9758a5d48db
CLANDRO_PKG_DEPENDS="libc++, libcairo, libsigc++-2.0"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dbuild-examples=false
-Dbuild-tests=false
-Dboost-shared=true
"

clandro_step_post_massage() {
	local _GUARD_FILE="lib/${CLANDRO_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
