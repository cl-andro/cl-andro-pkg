CLANDRO_PKG_HOMEPAGE=https://www.openexr.com/
CLANDRO_PKG_DESCRIPTION="Provides the specification and reference implementation of the EXR file format"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.4.4"
CLANDRO_PKG_SRCURL="https://github.com/AcademySoftwareFoundation/openexr/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=7c663c3c41da9354b5af277bc2fd1d2360788050b4e0751a32bcd50e8abaef8f
CLANDRO_PKG_DEPENDS="imath, libc++, zlib"
CLANDRO_PKG_CONFLICTS="openexr2"
CLANDRO_PKG_REPLACES="openexr2"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TESTING=OFF
"

clandro_step_pre_configure() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=33
	local v=$(sed -En 's/^set\(OPENEXR_LIB_SOVERSION\s+([0-9]+).*/\1/p' CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi

	# for code in openjph, which is downloaded by CMakeLists.txt of openexr at build-time
	if [[ "$CLANDRO_PKG_API_LEVEL" -lt 28 ]]; then
		CPPFLAGS+=" -Daligned_alloc=memalign"
	fi
}

clandro_step_post_massage() {
	shopt -s nullglob
	local f
	for f in lib/libImath*; do
		clandro_error_exit "File ${f} should not be contained in this package."
	done
	shopt -u nullglob
}
