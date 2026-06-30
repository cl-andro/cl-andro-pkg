CLANDRO_PKG_HOMEPAGE=https://github.com/libsdl-org/SDL_mixer
CLANDRO_PKG_DESCRIPTION="A simple multi-channel audio mixer"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_LICENSE_FILE="LICENSE.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.8.1"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/libsdl-org/SDL_mixer/releases/download/release-${CLANDRO_PKG_VERSION}/SDL2_mixer-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=cb760211b056bfe44f4a1e180cc7cb201137e4d1572f2002cc1be728efd22660
# Prevent updating to SDL3 version
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="fluidsynth, libxmp, libflac, libmodplug, libvorbis, libmpg123, opusfile, sdl2 | sdl2-compat"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="sdl2-compat"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-music-mod-xmp
--disable-music-mod-modplug-shared
--disable-music-midi-fluidsynth-shared
--disable-music-ogg-stb
--enable-music-ogg-vorbis
--disable-music-ogg-vorbis-shared
--disable-music-flac-drflac
--enable-music-flac-libflac
--disable-music-flac-libflac-shared
--disable-music-mp3-drmp3
--enable-music-mp3-mpg123
--disable-music-mp3-mpg123-shared
--disable-music-opus-shared
"
