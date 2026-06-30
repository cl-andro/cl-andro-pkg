CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/enlightenment/
CLANDRO_PKG_DESCRIPTION="Library that does image file loading and saving as well as rendering, manipulation, arbitrary polygon support"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="COPYING, COPYING-PLAIN"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.12.6"
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/enlightenment/imlib2-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=250f9752f69dc522e529a81aaa9395705f7fc312ff2453e5de59ac2ba1f2858f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="freetype, gdk-pixbuf, giflib, glib, libandroid-shmem, libbz2, libcairo, libheif, libid3tag, libjpeg-turbo, libjxl, liblzma, libpng, librsvg, libtiff, libwebp, libx11, libxcb, libxext, openjpeg, zlib"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-shmem -lm"
	autoreconf -fi
}
