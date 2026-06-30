CLANDRO_PKG_HOMEPAGE=https://libxmlplusplus.github.io/libxmlplusplus/
CLANDRO_PKG_DESCRIPTION="A C++ wrapper for the libxml2 XML parser library (version 5.0)"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@IntinteDAO"
CLANDRO_PKG_VERSION=5.6.0
CLANDRO_PKG_SRCURL=https://github.com/libxmlplusplus/libxmlplusplus/releases/download/${CLANDRO_PKG_VERSION}/libxml++-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=cd01ad15a5e44d5392c179ddf992891fb1ba94d33188d9198f9daf99e1bc4fec
CLANDRO_PKG_DEPENDS="libxml2, libiconv"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_post_massage() {
	local _GUARD_FILE="lib/${CLANDRO_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
