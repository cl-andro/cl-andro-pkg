CLANDRO_PKG_HOMEPAGE=https://rybczak.net/ncmpcpp/
CLANDRO_PKG_DESCRIPTION="NCurses Music Player Client (Plus Plus)"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.10.1"
CLANDRO_PKG_REVISION=8
CLANDRO_PKG_SRCURL="https://github.com/ncmpcpp/ncmpcpp/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=ddc89da86595d272282ae8726cc7913867b9517eec6e765e66e6da860b58e2f9
CLANDRO_PKG_DEPENDS="boost, fftw, libandroid-support, libc++, libcurl, libicu, libmpdclient, ncurses, readline, taglib"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-clock
--enable-outputs
--enable-visualizer
--with-taglib
"

clandro_step_pre_configure() {
	autoreconf -fi
	CXXFLAGS+=" -DNCURSES_WIDECHAR -U_XOPEN_SOURCE"
}
