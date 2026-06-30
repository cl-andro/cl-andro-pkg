CLANDRO_PKG_HOMEPAGE=http://taglib.github.io/
CLANDRO_PKG_DESCRIPTION="A Library for reading and editing the meta-data of several popular audio formats."
# License: LGPL-2.1, MPL-1.1
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="COPYING.LGPL, COPYING.MPL"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.2.1"
CLANDRO_PKG_SRCURL="https://github.com/taglib/taglib/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=8d920bfe302c943bab204ad5183fa0ea13cedee7f72f7256b665888de964d081
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, zlib, utf8cpp"
CLANDRO_PKG_BUILD_DEPENDS="boost, boost-headers"
CLANDRO_PKG_BREAKS="taglib-dev"
CLANDRO_PKG_REPLACES="taglib-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_INCLUDEDIR=$CLANDRO__PREFIX__INCLUDE_SUBDIR
-DBUILD_SHARED_LIBS=ON
-DWITH_MP4=ON
-DWITH_ASF=ON
-DWITH_DSF=ON
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2

	local v=$(sed -En 's/^set\(TAGLIB_SOVERSION_MAJOR\s+([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
