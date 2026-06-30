CLANDRO_PKG_HOMEPAGE=https://pipewire.org/
CLANDRO_PKG_DESCRIPTION="A server and user space API to deal with multimedia pipelines"
CLANDRO_PKG_LICENSE="MIT, LGPL-2.1, LGPL-3.0, GPL-2.0"
CLANDRO_PKG_LICENSE_FILE="COPYING, LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.9"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://gitlab.freedesktop.org/pipewire/pipewire/-/archive/${CLANDRO_PKG_VERSION}/pipewire-${CLANDRO_PKG_VERSION}.tar.bz2"
CLANDRO_PKG_SHA256=e606aa3f6d53ec4c56fe35034d35cadfe0bbea1a5275e4e006dd7d1abaec6b92
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="ffmpeg, glib, libc++, lua54, libopus, libsndfile, libwebrtc-audio-processing, lilv, ncurses, openssl, pulseaudio, readline"

# 'media-session' session-managers is disabled as it requires alsa.
# Since we are building without x11, dbus is disabled.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dgstreamer=disabled
-Dgstreamer-device-provider=disabled
-Dtests=disabled
-Dexamples=disabled
-Dpipewire-alsa=disabled
-Dalsa=disabled
-Dpipewire-jack=disabled
-Djack=disabled
-Ddbus=disabled
-Dsession-managers=['wireplumber']
-Dffmpeg=enabled
-Dwireplumber:system-lua=true
-Dwireplumber:system-lua-version=54
"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper

	sed -i "s/'-Werror=strict-prototypes',//" ${CLANDRO_PKG_SRCDIR}/meson.build
	CFLAGS+=" -Dindex=strchr -Drindex=strrchr"
	sed "s|@CLANDRO_PKG_BUILDER_DIR@|${CLANDRO_PKG_BUILDER_DIR}|g" \
		"${CLANDRO_PKG_BUILDER_DIR}"/reallocarray.diff | patch -p1
}
