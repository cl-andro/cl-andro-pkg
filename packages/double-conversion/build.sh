CLANDRO_PKG_HOMEPAGE=https://github.com/google/double-conversion
CLANDRO_PKG_DESCRIPTION="Binary-decimal and decimal-binary routines for IEEE doubles"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.4.0"
CLANDRO_PKG_SRCURL=https://github.com/google/double-conversion/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=42fd4d980ea86426e457b24bdfa835a6f5ad9517ddb01cdb42b99ab9c8dd5dc9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=3

	local v=$(sed -En 's/^\s*set_target_properties\(double-conversion\s+.*\s+SOVERSION\s+([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
