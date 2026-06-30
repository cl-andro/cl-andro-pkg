CLANDRO_PKG_HOMEPAGE=https://libjpeg-turbo.virtualgl.org
CLANDRO_PKG_DESCRIPTION="Library for reading and writing JPEG image files"
CLANDRO_PKG_LICENSE="IJG, BSD 3-Clause, ZLIB"
CLANDRO_PKG_LICENSE_FILE="README.ijg, LICENSE.md"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.1.4.1"
CLANDRO_PKG_SRCURL=https://github.com/libjpeg-turbo/libjpeg-turbo/releases/download/${CLANDRO_PKG_VERSION}/libjpeg-turbo-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ecae8008e2cc9ade2f2c1bb9d5e6d4fb73e7c433866a056bd82980741571a022
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="libjpeg-turbo-dev"
CLANDRO_PKG_REPLACES="libjpeg-turbo-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DWITH_JPEG8=1"

clandro_step_pre_configure() {
	# SOVERSION suffix is needed for SONAME of shared libs to avoid conflict
	# with system ones (in /system/lib64 or /system/lib):
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_SYSTEM_NAME=Linux"
}

clandro_step_post_massage() {
	# Check if SONAME is properly set:
	if ! readelf -d lib/libjpeg.so | grep -q '(SONAME).*\[libjpeg\.so\.'; then
		clandro_error_exit "SONAME for libjpeg.so is not properly set."
	fi

	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="
lib/libjpeg.so.8
lib/libturbojpeg.so.0
"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "SOVERSION guard check failed."
		fi
	done
}
