CLANDRO_PKG_HOMEPAGE=https://libwebsockets.org
CLANDRO_PKG_DESCRIPTION="Lightweight C websockets library"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.5.8"
CLANDRO_PKG_SRCURL=https://github.com/warmcat/libwebsockets/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b6ade658f4af3a823d0dc806ae5ef0623f0f4f5e2aeb895a0f77c4783840c30e
CLANDRO_PKG_DEPENDS="openssl, libcap, libuv, zlib"
CLANDRO_PKG_BREAKS="libwebsockets-dev"
CLANDRO_PKG_REPLACES="libwebsockets-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_LIBDIR=$CLANDRO__PREFIX__LIB_SUBDIR
-DCMAKE_INSTALL_INCLUDEDIR=$CLANDRO__PREFIX__INCLUDE_SUBDIR
-DLWS_WITHOUT_TESTAPPS=ON
-DLWS_WITH_STATIC=OFF
-DLWS_WITH_LIBUV=ON
-DLWS_WITHOUT_EXTENSIONS=OFF
-DLWS_BUILD_HASH=no_hash
"
CLANDRO_PKG_RM_AFTER_INSTALL="lib/pkgconfig/libwebsockets_static.pc"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=21

	local v=$(sed -En 's/^set\(SOVERSION\s+"?([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed. Expected ${_SOVERSION}, got ${v}."
	fi
}
