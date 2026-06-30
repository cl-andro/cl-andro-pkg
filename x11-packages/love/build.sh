CLANDRO_PKG_HOMEPAGE=https://love2d.org/
CLANDRO_PKG_DESCRIPTION="A framework you can use to make 2D games in Lua"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_LICENSE_FILE="license.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="11.5"
CLANDRO_PKG_REVISION=9
CLANDRO_PKG_SRCURL=https://github.com/love2d/love/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6f55c265be5e03696c4770150c4388f5cffbdb3727606724cf88332baab429f7
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="freetype, game-music-emu, libandroid-spawn, libc++, luajit, libmodplug, libogg, libtheora, libvorbis, libmpg123, openal-soft, opengl, sdl2 | sdl2-compat, zlib"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="sdl2-compat"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-gme
"

clandro_step_pre_configure() {
	mkdir -p platform/unix/m4
	ln -sf $CLANDRO_PREFIX/share/aclocal/sdl2.m4 platform/unix/m4/
	local _orig_prefix=${prefix}
	unset prefix
	./platform/unix/automagic
	export prefix=${_orig_prefix}

	export OBJCXX="$CXX"
	LDFLAGS+=" -landroid-spawn"
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
