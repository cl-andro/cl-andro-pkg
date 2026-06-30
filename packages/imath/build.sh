CLANDRO_PKG_HOMEPAGE=https://imath.readthedocs.io/
CLANDRO_PKG_DESCRIPTION="Library for vector/matrix and math operations, plus the half type"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.2.2"
CLANDRO_PKG_SRCURL=https://github.com/AcademySoftwareFoundation/Imath/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b4275d83fb95521510e389b8d13af10298ed5bed1c8e13efd961d91b1105e462
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_CONFLICTS="openexr2"
CLANDRO_PKG_REPLACES="openexr2"

clandro_step_pre_configure() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=30

	local v=$(sed -En 's/^set\(IMATH_LIB_SOVERSION ([0-9]+)\)/\1/p' \
		"$CLANDRO_PKG_SRCDIR"/CMakeLists.txt)

	if [[ "${v}" != "${_SOVERSION}" ]]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
