CLANDRO_PKG_HOMEPAGE=https://github.com/strukturag/libheif
CLANDRO_PKG_DESCRIPTION="HEIF (HEIC/AVIF) image encoding and decoding library"
CLANDRO_PKG_LICENSE="LGPL-3.0, MIT"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.21.2"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/strukturag/libheif/releases/download/v${CLANDRO_PKG_VERSION}/libheif-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=75f530b7154bc93e7ecf846edfc0416bf5f490612de8c45983c36385aa742b42
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, libaom, libc++, libdav1d, libde265, librav1e, libx264, libx265"
CLANDRO_PKG_BUILD_DEPENDS="libaom-static"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_PLUGIN_LOADING=OFF
"

clandro_step_pre_configure() {
	# SOVERSION suffix is needed for SONAME of shared libs to avoid conflict
	# with system ones (in /system/lib64 or /system/lib):
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_SYSTEM_NAME=Linux"
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/libheif.so.1"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "SOVERSION guard check failed."
		fi
	done

	# Check if SONAME is properly set:
	if ! readelf -d lib/libheif.so | grep -q '(SONAME).*\[libheif\.so\.'; then
		clandro_error_exit "SONAME for libheif.so is not properly set."
	fi
}
