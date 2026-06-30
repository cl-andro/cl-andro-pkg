CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/dosbox/
CLANDRO_PKG_DESCRIPTION="Emulator with builtin DOS for running DOS Games"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.74.3
CLANDRO_PKG_REVISION=23
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/dosbox/dosbox-${CLANDRO_PKG_VERSION/.3/-3}.tar.gz
CLANDRO_PKG_SHA256=c0d13dd7ed2ed363b68de615475781e891cd582e8162b5c3669137502222260a
CLANDRO_PKG_DEPENDS="libc++, libpng, libx11, sdl, sdl-net, zlib"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-dynamic-x86
--disable-fpu-x86
--disable-opengl
"

clandro_step_pre_configure() {
	# Avoid "error: ISO C++17 does not allow 'register' storage class specifier"
	CXXFLAGS+=" -std=c++11"
}
