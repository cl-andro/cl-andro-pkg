CLANDRO_PKG_HOMEPAGE=https://github.com/zlib-ng/minizip-ng
CLANDRO_PKG_DESCRIPTION="A zip manipulation library written in C"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.2.1"
CLANDRO_PKG_SRCURL=https://github.com/zlib-ng/minizip-ng/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3cc35c2cb925dbe67cc801e3234b31b0f30197812a99377352fa1b551ab3d011
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libbz2, libiconv, liblzma, openssl, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_INCLUDEDIR=include/minizip-ng
-DBUILD_SHARED_LIBS=ON
-DMZ_COMPAT=OFF
"
# ZSTD is disabled only because it breaks build of opencolorio when enabled.
# This may be resolved by building zstd with CMake, but that needs extra care
# such as SONAME change. I just cannot be bothered to do that for now.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DMZ_ZSTD=OFF"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=4

	local v=$(sed -En 's/^set\(SOVERSION\s+"?([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
