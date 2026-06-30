# x11-packages
CLANDRO_PKG_HOMEPAGE=https://www.ferzkopp.net/wordpress/2016/01/02/sdl_gfx-sdl2_gfx/
CLANDRO_PKG_DESCRIPTION="SDL-1.2 graphics drawing primitives, rotozoom and other supporting functions"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.0.26
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://www.ferzkopp.net/Software/SDL_gfx-2.0/SDL_gfx-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=7ceb4ffb6fc63ffba5f1290572db43d74386cd0781c123bc912da50d34945446
CLANDRO_PKG_DEPENDS="sdl"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-mmx
"

clandro_step_pre_configure() {
	cp $CLANDRO_PREFIX/share/aclocal/sdl.m4 m4/
	autoreconf -fi

	CPPFLAGS+=" -I$CLANDRO_PREFIX/include/SDL"
}
