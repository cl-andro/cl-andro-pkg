CLANDRO_PKG_HOMEPAGE=https://jpegxl.info/
CLANDRO_PKG_DESCRIPTION="JPEG XL image format reference implementation"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.11.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/libjxl/libjxl/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ab38928f7f6248e2a98cc184956021acb927b16a0dee71b4d260dc040a4320ea
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="brotli, giflib, glib, libc++, libffi, libiconv, libjpeg-turbo, libpng, zlib"
CLANDRO_PKG_BUILD_DEPENDS="gdk-pixbuf, littlecms"
CLANDRO_PKG_SUGGESTS="gdk-pixbuf"
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DJPEGXL_ENABLE_JNI=False
-DJPEGXL_FORCE_SYSTEM_BROTLI=True
-DJPEGXL_ENABLE_PLUGINS=True
-DJPEGXL_ENABLE_PLUGIN_GDKPIXBUF=True
-DJPEGXL_ENABLE_PLUGIN_GIMP210=False
-DJPEGXL_BUNDLE_LIBPNG=False
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after RELEASE / SOVERSION is changed.
	local _SOVERSION=0.11

	for a in MAJOR SO_MINOR; do
		local _${a}=$(sed -En 's/^set\(JPEGXL_'"${a}"'_VERSION\s+([0-9]+).*/\1/p' \
				lib/CMakeLists.txt)
	done
	local v="${_MAJOR}"
	if [ "${_SO_MINOR}" != "0" ]; then
		v+=".${_SO_MINOR}"
	fi
	if [ "${_SOVERSION}" != "${v}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi

	./deps.sh
}
