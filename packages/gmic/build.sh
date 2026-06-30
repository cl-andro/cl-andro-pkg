CLANDRO_PKG_HOMEPAGE=https://gmic.eu
CLANDRO_PKG_DESCRIPTION="Full-featured framework for image processing"
CLANDRO_PKG_LICENSE="CeCILL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.7.2"
CLANDRO_PKG_SRCURL="https://gmic.eu/files/source/gmic_$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=4b7018cc4dc88bbb933564f2c0dc31d3090989c4a7f6eee2a490f98b2861b32f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fftw, imath, libc++, libcurl, libjpeg-turbo, libpng, libtiff, libx11, openexr, zlib"
CLANDRO_PKG_BUILD_DEPENDS="graphicsmagick"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure() {
	return
}

clandro_step_make() {
	cd src/
	make STRIP="$STRIP" OPT_CFLAGS="$CXXFLAGS" cli cli_gm
}

clandro_step_make_install() {
	cp src/gmic $CLANDRO_PREFIX/bin/
	cp src/gmic-gm $CLANDRO_PREFIX/bin/
	cp man/gmic.1.gz $CLANDRO_PREFIX/share/man/man1/
	cp man/gmic.1.gz $CLANDRO_PREFIX/share/man/man1/gmic-gm.1.gz
}
