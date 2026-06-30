CLANDRO_PKG_HOMEPAGE=http://www.ece.uvic.ca/~frodo/jasper/
CLANDRO_PKG_DESCRIPTION="Library for manipulating JPEG-2000 files"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.2.9"
CLANDRO_PKG_SRCURL=https://github.com/jasper-software/jasper/archive/refs/tags/version-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b0e5af6b54c274b9670c7e32ddbf6c802d88c896062d760267695dd0aa7014ff
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="libjpeg-turbo"
CLANDRO_PKG_BREAKS="libjasper-dev"
CLANDRO_PKG_REPLACES="libjasper-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-H$CLANDRO_PKG_SRCDIR
-B$CLANDRO_PKG_BUILDDIR
-DJAS_STDC_VERSION=201112L
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=7

	local v="$(sed -En 's/^.*set\(JAS_SO_VERSION ([0-9]+).*$/\1/p' \
			CMakeLists.txt)"
	if [ "${_SOVERSION}" != "${v}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
