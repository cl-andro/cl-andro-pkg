CLANDRO_PKG_HOMEPAGE=https://aomedia.org/
CLANDRO_PKG_DESCRIPTION="AV1 Video Codec Library"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_LICENSE_FILE="LICENSE, PATENTS"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.13.3"
CLANDRO_PKG_SRCURL=https://storage.googleapis.com/aom-releases/libaom-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=446a4ae9741cb8f3eeb98c949d25f91b48cb2b8569cae975c4b737392e9024fc
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DCMAKE_INSTALL_LIBDIR=$CLANDRO__PREFIX__LIB_SUBDIR
-DCMAKE_INSTALL_INCLUDEDIR=$CLANDRO__PREFIX__INCLUDE_SUBDIR
"

clandro_step_pre_configure() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=3

	local a
	for a in LT_CURRENT LT_AGE; do
		local _${a}=$(sed -En 's/^set\('"${a}"'\s+([0-9]+).*/\1/p' \
				CMakeLists.txt)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
