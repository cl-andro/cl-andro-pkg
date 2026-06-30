CLANDRO_PKG_HOMEPAGE=https://github.com/snapcast/snapcast
CLANDRO_PKG_DESCRIPTION="A multiroom client-server audio player (server)"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.35.0"
CLANDRO_PKG_SRCURL="https://github.com/snapcast/snapcast/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=cb75a71479bf52910bf5f47ae8120ec41c89459b0d77d7cd560e674e437ef050
CLANDRO_PKG_DEPENDS="libc++, libexpat, libflac, libogg, libopus, libsoxr, libvorbis, openssl"
CLANDRO_PKG_BUILD_DEPENDS="boost, boost-headers"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBoost_INCLUDE_DIR=$CLANDRO_PREFIX/include
-DANDROID_NO_TERMUX=OFF
-DBUILD_WITH_ALSA=OFF
-DBUILD_WITH_AVAHI=OFF
-DBUILD_WITH_PULSE=ON
-DBUILD_TESTS=OFF
"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_post_get_source() {
	# Future-proof way of pretending not to be Android.
	find . -name CMakeLists.txt | xargs -n 1 \
		sed -i -E 's/if\s*\((.*\s|)ANDROID/\0_NO_TERMUX/g'
}

clandro_step_pre_configure() {
	LDFLAGS+=" -llog"
}
