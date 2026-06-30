CLANDRO_PKG_HOMEPAGE=https://proj.org
CLANDRO_PKG_DESCRIPTION="Generic coordinate transformation software"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Henrik Grimler @Grimler91"
CLANDRO_PKG_VERSION="9.8.1"
CLANDRO_PKG_SRCURL=https://github.com/OSGeo/proj.4/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=39648c91c269de34b053f0b8284d87ef70de68244706f602db8c96763bd30246
CLANDRO_PKG_DEPENDS="libc++, libsqlite, sqlite, libtiff, libcurl"
CLANDRO_PKG_BREAKS="proj-dev"
CLANDRO_PKG_REPLACES="proj-dev"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=25

	local v=$(sed -En 's/^set\(PROJ_SOVERSION\s+([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
