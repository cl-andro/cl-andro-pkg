CLANDRO_PKG_HOMEPAGE=https://audacious-media-player.org
CLANDRO_PKG_DESCRIPTION="Plugins for Audacious"
# "The plugins themselves are distributed under their own distribution terms."
# Licenses: GPL-2.0, LGPL-2.1, GPL-3.0, BSD 2-Clause, BSD 3-Clause, MIT, ISC
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.5.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://distfiles.audacious-media-player.org/audacious-plugins-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=f4feedc32776acfa9d24701d3b794fc97822f76da6991e91e627e70e561fdd3b
CLANDRO_PKG_DEPENDS="audacious, ffmpeg, fluidsynth, glib, libc++, libcue, libcurl, libflac, libmp3lame, libogg, libopenmpt, libsamplerate, libsndfile, libsoxr, libvorbis, libx11, libxml2, libmpg123, opusfile, pulseaudio, qt6-qtbase, qt6-qtmultimedia, sdl2 | sdl2-compat, zlib"
CLANDRO_PKG_BUILD_DEPENDS="qt6-qtbase-cross-tools"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="sdl2-compat"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-gtk --disable-wavpack --disable-qtglspectrum --disable-neon"
