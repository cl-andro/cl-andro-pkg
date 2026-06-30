CLANDRO_PKG_HOMEPAGE=https://tenacityaudio.org/
CLANDRO_PKG_DESCRIPTION="An easy-to-use, privacy-friendly, FLOSS, cross-platform multi-track audio editor (Audacity fork)"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@3ls-it"
CLANDRO_PKG_VERSION="1.3.4"
CLANDRO_PKG_SRCURL=git+https://codeberg.org/tenacityteam/tenacity
CLANDRO_PKG_GIT_BRANCH="v${CLANDRO_PKG_VERSION}"
CLANDRO_PKG_DEPENDS="ffmpeg, gdk-pixbuf, glib, gtk3, libc++, vamp-plugin-sdk, libexpat, libflac, libid3tag, libogg, libopus, libsndfile, libsoundtouch, libsoxr, libuuid, libvorbis, libwavpack, libmpg123, opusfile, portaudio, portmidi, wxwidgets"
CLANDRO_PKG_BUILD_DEPENDS="libjpeg-turbo, libjpeg-turbo-static, libmp3lame, libpng, patchelf, rapidjson, zlib"
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_STRIP=llvm-strip
-DVCPKG=Off
-DUSE_MIDI=OFF
"

clandro_step_post_get_source() {
		# Sanity check just in case of upstream changes
		[ -d "$CLANDRO_PKG_SRCDIR/libraries/lib-ffmpeg-support" ] || \
				clandro_error_exit "Expected libraries/lib-ffmpeg-support/ not found"

		cp -a "$CLANDRO_PKG_BUILDER_DIR/ffmpeg8/." \
				"$CLANDRO_PKG_SRCDIR/libraries/lib-ffmpeg-support/"
}

clandro_step_pre_configure() {
		CPPFLAGS+=" -Dushort=u_short -Dulong=u_long"
		CXXFLAGS+=" -std=c++17"
		LDFLAGS+=" -Wl,-rpath=$CLANDRO_PREFIX/lib/tenacity"
}

clandro_step_post_make_install() {
		mv "$CLANDRO_PREFIX/share/pixmaps/gnome-mime-application-x-audacity-project.xpm" \
		"$CLANDRO_PREFIX/share/pixmaps/gnome-mime-application-x-tenacity-project.xpm"
}

clandro_step_create_debscripts() {
	cat <<-EOF > ./postinst
		#!$CLANDRO_PREFIX/bin/sh
		echo
		echo "********"
		echo "Tenacity can not use microphone until you grant microphone access to Termux:API."
		echo "********"
		echo
	EOF
}
