CLANDRO_PKG_HOMEPAGE=https://github.com/zxing-cpp/zxing-cpp
CLANDRO_PKG_DESCRIPTION="An open-source, multi-format 1D/2D barcode image processing library implemented in C++"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.0.2"
CLANDRO_PKG_SRCURL="https://github.com/zxing-cpp/zxing-cpp/releases/download/v${CLANDRO_PKG_VERSION}/zxing-cpp-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=e957f13e2ad4e31badb3d9af3f6ba8999a3ca3c9cc4d6bafc98032f9cce1a090
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DZXING_EXAMPLES=ON
-DZXING_BLACKBOX_TESTS=OFF
-DZXING_WRITERS=BOTH
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=4

	local _ver=$(sed -En 's/^set \(ZXING_SONAME\s+([0-9]+).*/\1/p' "$CLANDRO_PKG_SRCDIR"/core/CMakeLists.txt)

	if [[ ! "${_ver}" ]] || [[ "${_ver}" != "${_SOVERSION}" ]]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
