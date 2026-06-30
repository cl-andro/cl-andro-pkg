CLANDRO_PKG_HOMEPAGE="https://tvheadend.org/"
CLANDRO_PKG_DESCRIPTION="TV streaming server for Linux and Android supporting DVB-S, DVB-S2 and other formats."
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="Aditya Alok <alok@termux.org> & @clandro"
CLANDRO_PKG_VERSION=4.2.8
CLANDRO_PKG_REVISION=12
CLANDRO_PKG_SRCURL="https://github.com/tvheadend/tvheadend/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=1aef889373d5fad2a7bd2f139156d4d5e34a64b6d38b87b868a2df415f01f7ad
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="dbus, libandroid-execinfo, libdvbcsa, libiconv, openssl, tvheadend-data, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-android
--enable-pngquant
--enable-dvbcsa
--disable-libav
--disable-hdhomerun_static
--disable-ffmpeg_static
--disable-avahi
--nowerror
"

clandro_step_pre_configure() {
	clandro_setup_cmake

	CFLAGS=" -I$CLANDRO_PKG_BUILDDIR/src $CFLAGS $CPPFLAGS -fcommon"
	LDFLAGS+=" -landroid-execinfo"

	# Arm does not support mmx and sse2 instructions, still checks return true
	if [ "${CLANDRO_ARCH}" = "arm" ] || [ "${CLANDRO_ARCH}" = "aarch64" ]; then
		patch -p1 <"${CLANDRO_PKG_BUILDER_DIR}/disable-mmx-sse2"
	fi
}
