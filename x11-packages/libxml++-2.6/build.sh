CLANDRO_PKG_HOMEPAGE=https://libxmlplusplus.github.io/libxmlplusplus/
CLANDRO_PKG_DESCRIPTION="A C++ wrapper for the libxml2 XML parser library"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
_MAJOR_VERSION=2.42
CLANDRO_PKG_VERSION=${_MAJOR_VERSION}.2
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/libxml++/${_MAJOR_VERSION}/libxml++-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=a433987f54cc1ecaa84af26af047a62df9e884574e0d686e5ddc6f70441c152b
CLANDRO_PKG_DEPENDS="libc++, libglibmm-2.4, libxml2"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dvalidation=false
-Dbuild-examples=false
-Dbuild-tests=false
-Dmsvc14x-parallel-installable=false
"

clandro_step_post_massage() {
	local _GUARD_FILE="lib/${CLANDRO_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
