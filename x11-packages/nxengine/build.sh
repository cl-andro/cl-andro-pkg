CLANDRO_PKG_HOMEPAGE=https://nxengine.sourceforge.net
CLANDRO_PKG_DESCRIPTION="Open-source rewrite engine of the Cave Story for Dingux and MotoMAGX"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.0.4-Rev4
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://github.com/EXL/NXEngine/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d467c112e81d4c56337ebf6968bd8bd781bce9140f674e72009a5274d2c15784
CLANDRO_PKG_DEPENDS="libc++, pulseaudio, sdl, sdl-ttf"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	make -j $CLANDRO_PKG_MAKE_PROCESSES -f Makefile.linux \
		CC="$CC" \
		CXX="$CXX" \
		LINK="$CXX" \
		CFLAGS="$CFLAGS $CPPFLAGS -Wno-c++11-narrowing" \
		CXXFLAGS="$CXXFLAGS $CPPFLAGS -Wno-c++11-narrowing" \
		LFLAGS="$LDFLAGS"
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin ./nx
	install -Dm600 -t $CLANDRO_PREFIX/share/nxengine \
		smalfont.bmp DroidSansMono.ttf font.ttf \
		sprites.sif tilekey.dat
}
