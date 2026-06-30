CLANDRO_PKG_HOMEPAGE=https://github.com/lipnitsk/libcue/
CLANDRO_PKG_DESCRIPTION="CUE Sheet Parser Library"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.3.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/lipnitsk/libcue/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=cc1b3a65c60bd88b77a1ddd1574042d83cf7cc32b85fe9481c99613359eb7cfe
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="libcue-dev"
CLANDRO_PKG_REPLACES="libcue-dev"
# To avoid picking up cross-compiled flex and bison:
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
-DBISON_EXECUTABLE=$(command -v bison)
-DFLEX_EXECUTABLE=$(command -v flex)
-DBUILD_SHARED_LIBS=ON
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2

	local v=$(sed -En 's/^SET\(PACKAGE_SOVERSION\s+([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
