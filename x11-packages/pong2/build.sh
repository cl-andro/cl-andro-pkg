CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/pong2.berlios/
CLANDRO_PKG_DESCRIPTION="A Three Dimensional Pong Game"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.1.3
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://download.sourceforge.net/pong2.berlios/pong2-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=7b3601b35a4f2d64e2a4e85b9d6ad2fe84a79d40a39be2909f3e52b094307639
CLANDRO_PKG_DEPENDS="glu, libc++, opengl, openssl, sdl, sdl-image"
CLANDRO_PKG_GROUPS="games"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	cp $CLANDRO_PREFIX/share/aclocal/sdl.m4 m4/
	autoreconf -fi

	CPPFLAGS+=" -I$CLANDRO_PREFIX/include/SDL"
}
