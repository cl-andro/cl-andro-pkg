# x11-packages
CLANDRO_PKG_HOMEPAGE=https://www.widelands.org/
CLANDRO_PKG_DESCRIPTION="A free, open source real-time strategy game with singleplayer campaigns and a multiplayer mode"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0
CLANDRO_PKG_SRCURL=https://github.com/widelands/widelands/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1dab0c4062873cc72c5e0558f9e9620b0ef185f1a78923a77c4ce5b9ed76031a
CLANDRO_PKG_DEPENDS="glew, libandroid-execinfo, libandroid-glob, libcurl, libicu, libpng, opengl, sdl2, sdl2-image, sdl2-mixer, sdl2-ttf, widelands-data"
CLANDRO_PKG_BUILD_DEPENDS="boost, boost-headers"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_PREFIX=$CLANDRO_PREFIX/bin
-DWL_INSTALL_BASEDIR=$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME
-DWL_INSTALL_DATADIR=$CLANDRO_PREFIX/share/$CLANDRO_PKG_NAME
-DGTK_UPDATE_ICON_CACHE=OFF
-DOPTION_BUILD_TESTS=OFF
"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob -landroid-execinfo"
}
