CLANDRO_PKG_HOMEPAGE="https://github.com/OSGeo/libgeotiff"
CLANDRO_PKG_DESCRIPTION="Library for handling TIFF for georeferenced raster imagery"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.7.4"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://github.com/OSGeo/libgeotiff/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=c581ff502c6b1dc012fad1031d95293ea5f5ff250d9502de382aced8c7d28565
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libtiff, proj"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DWITH_TIFF=ON
-DWITH_TOWGS84=ON
-DBUILD_SHARED_LIBS=ON
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=5

	local e=$(sed -En 's/^libgeotiff_la_LDFLAGS\s*=.*\s+-version-info\s+([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			libgeotiff/Makefile.am)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR+="/libgeotiff"
}
