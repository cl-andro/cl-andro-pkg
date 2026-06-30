CLANDRO_PKG_HOMEPAGE=http://www.graphicsmagick.org/
CLANDRO_PKG_DESCRIPTION="Collection of image processing tools"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3.46"
# Bandwith limited on main ftp site, so it's asked to use sourceforge instead:
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/project/graphicsmagick/graphicsmagick/${CLANDRO_PKG_VERSION}/GraphicsMagick-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=c7c706a505e9c6c3764156bb94a0c9644d79131785df15a89c9f8721d1abd061
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="freetype, libbz2, libc++, libde265, libheif, libjasper, libjpeg-turbo, libjxl, liblzma, libpng, libtiff, libwebp, libxml2, littlecms, zlib, zstd"
CLANDRO_PKG_BREAKS="graphicsmagick-dev"
CLANDRO_PKG_REPLACES="graphicsmagick++, graphicsmagick-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_ftime=no
--with-fontpath=/system/fonts
--without-x
"

clandro_step_pre_configure() {
	pushd "${CLANDRO_PKG_SRCDIR}"
	# Otherwise shared libraries depend on libomp.so
	sed -i "s/-lomp/-l:libomp.a/g" configure.ac
	autoreconf -fi
	popd
	CFLAGS+=" -fPIC"
	CXXFLAGS+=" -fPIC"
}
