CLANDRO_PKG_HOMEPAGE=https://www.musicpd.org
CLANDRO_PKG_DESCRIPTION="Music player daemon"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.24.10"
CLANDRO_PKG_SRCURL=https://github.com/MusicPlayerDaemon/MPD/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=e1a82ed2a7308928360fed633424c8c8fe1ef40eb9051721491cb81725934abc
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libchromaprint, dbus, ffmpeg, game-music-emu, libao, libbz2, libc++, libcurl, libexpat, libflac, libicu, libid3tag, libmad, libmp3lame, libmodplug, libmpdclient, libnfs, libogg, libopenmpt, libopus, libsamplerate, libsndfile, libsoxr, libsqlite, libvorbis, libwavpack, libmpg123, openal-soft, pcre2, pulseaudio, yajl, zlib, fmt"
CLANDRO_PKG_BUILD_DEPENDS="libiconv"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dalsa=disabled
-Depoll=false
-Dsndio=disabled
-Dzlib=enabled
-Dicu=enabled
-Diconv=enabled
-Dpcre=enabled
-Dexpat=enabled
-Ddbus=enabled
-Dipv6=enabled
"
CLANDRO_PKG_CONFFILES="etc/mpd.conf"
CLANDRO_PKG_SERVICE_SCRIPT=("mpd" "if [ -f \"$CLANDRO_ANDROID_HOME/.mpd/mpd.conf\" ]; then CONFIG=\"$CLANDRO_ANDROID_HOME/.mpd/mpd.conf\"; else CONFIG=\"$CLANDRO_PREFIX/etc/mpd.conf\"; fi\nexec mpd --stdout --no-daemon \$CONFIG 2>&1")
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $CLANDRO_PREFIX.
	if $CLANDRO_ON_DEVICE_BUILD; then
		clandro_error_exit "Package '$CLANDRO_PKG_NAME' is not safe for on-device builds."
	fi

	CXXFLAGS+=" -DTERMUX -UANDROID -std=c++20"
	LDFLAGS+=" -lOpenSLES"
	rm -f $CLANDRO_PREFIX/etc/mpd.conf
}

clandro_step_post_make_install() {
	install -Dm600 $CLANDRO_PKG_SRCDIR/doc/mpdconf.example $CLANDRO_PREFIX/etc/mpd.conf
}

clandro_step_create_debscripts() {
	echo "#!$CLANDRO_PREFIX/bin/sh" >postinst
	echo 'mkdir -p $HOME/.mpd/playlists' >>postinst
}
