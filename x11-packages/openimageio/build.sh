CLANDRO_PKG_HOMEPAGE=http://www.openimageio.org/
CLANDRO_PKG_DESCRIPTION="A library for reading and writing images, including classes, utilities, and applications"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.1.13.1"
CLANDRO_PKG_SRCURL="https://github.com/OpenImageIO/oiio/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=0fc59b8e2708ded02d3793b8f3331f037ed49bfcde38158f05ac0e876ebb85b7
# configure-time error if ptex and ptex-static are not both installed
CLANDRO_PKG_DEPENDS="boost, dcmtk, ffmpeg, fmt, freetype, glew, imath, libc++, libhdf5, libheif, libjpeg-turbo, libjxl, libpng, libraw, libtbb, libtiff, libwebp, libyaml-cpp, opencolorio, opencv, openexr, openjpeg, openvdb, ptex, pybind11, python, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers, fontconfig, libjpeg-turbo-static, libpugixml, libxrender, mesa, ptex-static, robin-map"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DCMAKE_CXX_STANDARD=17
-DUSE_PYTHON=ON
-DINTERNALIZE_FMT=OFF
-DOIIO_BUILD_TOOLS=ON
-DOIIO_BUILD_TESTS=OFF
-DUSE_EXTERNAL_PUGIXML=ON
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=31

	local v=$(sed -En 's/^set \(OpenImageIO_VERSION "([0-9]+.[0-9]+).*/\1/p' "$CLANDRO_PKG_SRCDIR"/CMakeLists.txt)
	v="${v//./}"

	if [[ "${v}" != "${_SOVERSION}" ]]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	# for code in openjph, which is downloaded by CMakeLists.txt of openexr at build-time
	if [[ "$CLANDRO_PKG_API_LEVEL" -lt 28 ]]; then
		CPPFLAGS+=" -Daligned_alloc=memalign"
	fi
}
