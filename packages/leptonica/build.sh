CLANDRO_PKG_HOMEPAGE=http://www.leptonica.com/
CLANDRO_PKG_DESCRIPTION="Library for image processing and image analysis"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_LICENSE_FILE="leptonica-license.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.87.0"
CLANDRO_PKG_SRCURL=https://github.com/DanBloomberg/leptonica/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=fa2b40c5caea96d1bb93a97486262aed8731b69ce25a84a6bf5d25323e33f631
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="giflib, libjpeg-turbo, libpng, libtiff, libwebp, openjpeg, zlib"
CLANDRO_PKG_BREAKS="leptonica-dev"
CLANDRO_PKG_REPLACES="leptonica-dev"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=6

	local v=$(sed -En 's/^.*SOVERSION ([0-9]+).*$/\1/p' src/CMakeLists.txt)
	if [ "${_SOVERSION}" != "${v}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	# Silence tmpfile warnings:
	find src -name '*.c' | xargs -n 1 \
		sed -i 's/L_INFO("work-around: writing to a temp file\\n", __func__)/((void)0)/'

	./autogen.sh
}
