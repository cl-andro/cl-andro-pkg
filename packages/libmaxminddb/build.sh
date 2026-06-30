CLANDRO_PKG_HOMEPAGE=https://dev.maxmind.com/geoip/geoip2/
CLANDRO_PKG_DESCRIPTION="MaxMind GeoIP2 database - library and utilities"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.13.3"
CLANDRO_PKG_SRCURL=https://github.com/maxmind/libmaxminddb/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=341dfbeef96bd58c3e1e98ffe39ac4fa1110b72b20149f312345fc43cc3559f9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="libmaxminddb-dev"
CLANDRO_PKG_REPLACES="libmaxminddb-dev"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-tests"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0.0.7

	local v=$(sed -En 's/^set\(MAXMINDDB_SOVERSION\s+([0-9.]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	./bootstrap
}
