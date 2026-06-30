CLANDRO_PKG_HOMEPAGE=https://enblend.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="A tool for compositing images using a Burt&Adelson multiresolution spline"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.2.0p20161007"
CLANDRO_PKG_REVISION=8
CLANDRO_PKG_SRCURL="https://dev.gentoo.org/~soap/distfiles/enblend-${CLANDRO_PKG_VERSION//p/_p}.tar.xz"
CLANDRO_PKG_SHA256=4fe05af3d697bd6b2797facc8ba5aeabdc91e233156552301f1c7686232ff4c3
CLANDRO_PKG_DEPENDS="gsl, libandroid-glob, libc++, libtiff, libvigra, littlecms"
CLANDRO_PKG_BUILD_DEPENDS="boost, boost-headers, libjpeg-turbo, libpng, zlib"

clandro_step_pre_configure() {
	autoreconf -fi

	# Code uses std::unary_function and std::binary_function which is removed in c+11:
	CXXFLAGS+=" -std=c++98"

	LDFLAGS+=" -landroid-glob"
}
