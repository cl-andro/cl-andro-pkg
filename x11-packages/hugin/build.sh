CLANDRO_PKG_HOMEPAGE=http://hugin.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Toolchain to create panoramic images for every occasion"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2025.0.1"
CLANDRO_PKG_SRCURL="https://downloads.sourceforge.net/hugin/hugin-${CLANDRO_PKG_VERSION}.tar.bz2"
CLANDRO_PKG_SHA256=7cf8eb33a6a8848cc7f816faf4bc88389228883d5513136dccb5cb243912ab79
CLANDRO_PKG_DEPENDS="boost, enblend, exiftool, exiv2, fftw, glew, glu, imath, libc++, libflann, liblz4, libpano13, libsqlite, libtiff, libvigra, libx11, littlecms, openexr, opengl, wxwidgets"
# libjpeg-turbo, libpng and zlib are detected but not linked against
CLANDRO_PKG_BUILD_DEPENDS="boost-headers, libjpeg-turbo, libpng, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DwxWidgets_CONFIG_EXECUTABLE=$CLANDRO_PREFIX/bin/wx-config
-DDISABLE_DPKG=ON
"

clandro_step_pre_configure() {
	CPPFLAGS+=" -D_GNU_SOURCE -Wno-deprecated-register -Wno-deprecated-declarations"
	LDFLAGS+=" -fopenmp -static-openmp -Wl,-rpath=$CLANDRO_PREFIX/lib/hugin"
}
