# x11-packages
CLANDRO_PKG_HOMEPAGE=https://love2d.org/
CLANDRO_PKG_DESCRIPTION="A framework you can use to make 2D games in Lua"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_LICENSE_FILE="license.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.10.2
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/love2d/love/releases/download/${CLANDRO_PKG_VERSION}/love-${CLANDRO_PKG_VERSION}-linux-src.tar.gz
CLANDRO_PKG_SHA256=b26b306b113158927ae12d2faadb606eb1db49ffdcd7592d6a0a3fc0af21a387
CLANDRO_PKG_DEPENDS="freetype, game-music-emu, libandroid-spawn, libc++, libluajit, libmodplug, libogg, libphysfs, libtheora, libvorbis, mpg123, openal-soft, opengl, sdl2, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-gme
--with-lua=luajit
ac_cv_prog_LUA_EXECUTABLE=luajit
"

clandro_step_pre_configure() {
	case "$CLANDRO_PKG_VERSION" in
		0.10.*|*:0.10.* ) ;;
		* ) clandro_error_exit "Invalid version '$CLANDRO_PKG_VERSION' for package '$CLANDRO_PKG_NAME'." ;;
	esac

	export OBJCXX="$CXX"
	CPPFLAGS+=" -DluaL_reg=luaL_Reg"
	LDFLAGS+=" -landroid-spawn"
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
