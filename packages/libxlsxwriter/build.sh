CLANDRO_PKG_HOMEPAGE=https://libxlsxwriter.github.io/
CLANDRO_PKG_DESCRIPTION="A C library for creating Excel XLSX files"
CLANDRO_PKG_LICENSE="BSD 2-Clause, BSD 3-Clause, ZLIB, MPL-2.0, MIT, Public Domain"
CLANDRO_PKG_LICENSE_FILE="License.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.4"
CLANDRO_PKG_SRCURL=https://github.com/jmcnamara/libxlsxwriter/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e0db59fc248a5ffa465a05ea83a9d466d4bca0e53ab42771515d4ebb467a41c1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
CLANDRO_PKG_DEPENDS="libminizip"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DUSE_SYSTEM_MINIZIP=ON
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=11

	local v=$(sed -En 's/.*LXW_SOVERSION .*"(.*)".*/\1/p' \
			include/xlsxwriter.h)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed. Expected ${_SOVERSION}, got ${v}."
	fi
}
