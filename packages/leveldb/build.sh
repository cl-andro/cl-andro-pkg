CLANDRO_PKG_HOMEPAGE=https://github.com/google/leveldb
CLANDRO_PKG_DESCRIPTION="Fast key-value storage library"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.23
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/google/leveldb/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9a37f8a6174f09bd622bc723b55881dc541cd50747cbd08831c2a82d620f6d76
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libsnappy"
CLANDRO_PKG_BREAKS="leveldb-dev"
CLANDRO_PKG_REPLACES="leveldb-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=TRUE
-DLEVELDB_BUILD_TESTS=OFF
-DLEVELDB_BUILD_BENCHMARKS=OFF
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local v=$(echo ${CLANDRO_PKG_VERSION#*:} | cut -d . -f 1)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
