CLANDRO_PKG_HOMEPAGE=https://gitlab.com/azelpg/azpainter
CLANDRO_PKG_DESCRIPTION="Full color painting software for Unix-like systems for illustration drawing"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:3.0.12"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_SRCURL=https://gitlab.com/azelpg/azpainter/-/archive/v${CLANDRO_PKG_VERSION:2}/azpainter-${CLANDRO_PKG_VERSION:2}.tar.bz2
CLANDRO_PKG_SHA256=13fe5543f592892e2885ad06bd0394062b2425dd1688cbb09676097302c8cd8c
CLANDRO_PKG_DEPENDS="fontconfig, freetype, libandroid-shmem, libiconv, libjpeg-turbo, libpng, libtiff, libwebp, libx11, libxcursor, libxext, libxi, zlib"
CLANDRO_PKG_RECOMMENDS="hicolor-icon-theme"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CPPFLAGS="-I$CLANDRO_PKG_SRCDIR/src/include $CPPFLAGS"
}

clandro_step_configure() {
	clandro_setup_ninja
	./configure --prefix="$CLANDRO_PREFIX" \
		CC="$CC" \
		CFLAGS="$CPPFLAGS $CFLAGS" \
		LDFLAGS="$LDFLAGS" \
		LIBS="-liconv -landroid-shmem -lz"
}

clandro_step_make() {
	cd build
	ninja
}

clandro_step_make_install() {
	cd build
	ninja install
}
