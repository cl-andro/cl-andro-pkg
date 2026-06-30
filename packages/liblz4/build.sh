CLANDRO_PKG_HOMEPAGE=https://lz4.github.io/lz4/
CLANDRO_PKG_DESCRIPTION="Fast LZ compression algorithm library"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.10.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/lz4/lz4/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=537512904744b35e232912055ccf8ec66d768639ff3abe5788d90d792ec5f48b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="liblz4-dev"
CLANDRO_PKG_REPLACES="liblz4-dev"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local v=$(sed -En 's/^#define LZ4_VERSION_MAJOR +([0-9]+) +.*$/\1/p' \
			lib/lz4.h)
	if [ "${_SOVERSION}" != "${v}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR+=/build/cmake
}
