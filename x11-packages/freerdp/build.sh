CLANDRO_PKG_HOMEPAGE=https://www.freerdp.com/
CLANDRO_PKG_DESCRIPTION="A free remote desktop protocol library and clients"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.26.0"
CLANDRO_PKG_SRCURL=https://github.com/FreeRDP/FreeRDP/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=ae3b1c0b8e334ecbc2c784bce266249309fad32a0ef41947ce5c059eb18e2059
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-shmem, libcairo, libicu, libjpeg-turbo, libusb, libwayland, libx11, libxcursor, libxdamage, libxext, libxfixes, libxi, libxinerama, libxkbcommon, libxkbfile, libxrandr, libxrender, libxv, openssl, pulseaudio, zlib"
CLANDRO_PKG_BUILD_DEPENDS="libwayland-cross-scanner, libwayland-protocols"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DANDROID_NO_TERMUX=OFF
-DWITH_LIBSYSTEMD=OFF
-DWITH_PULSE=ON
-DWITH_OPENSLES=OFF
-DWITH_OSS=OFF
-DWITH_ALSA=OFF
-DWITH_CUPS=OFF
-DWITH_PCSC=OFF
-DWITH_FFMPEG=OFF
-DWITH_JPEG=ON
-DWITH_OPENSSL=ON
-DWITH_SERVER=ON
-DWITH_OPUS=OFF
-DWITH_SWSCALE=OFF
-DWITH_FUSE=OFF
-DWITH_KRB5=OFF
"

clandro_step_post_get_source() {
	find "$CLANDRO_PKG_SRCDIR" -name CMakeLists.txt -o -name '*.cmake' | \
		xargs -n 1 sed -i \
		-e 's/\([^A-Za-z0-9_]ANDROID\)\([^A-Za-z0-9_]\)/\1_NO_TERMUX\2/g' \
		-e 's/\([^A-Za-z0-9_]ANDROID\)$/\1_NO_TERMUX/g'
}

clandro_step_pre_configure() {
	clandro_setup_wayland_cross_pkg_config_wrapper

	CFLAGS+=" -Wno-incompatible-function-pointer-types"
	CPPFLAGS+=" -D__USE_BSD"
	LDFLAGS+=" -landroid-shmem"
}

clandro_step_post_configure() {
	mkdir -p "${CLANDRO_PKG_TMPDIR}/bin"
	clang "${CLANDRO_PKG_SRCDIR}/client/common/man/generate_argument_manpage.c" -o "${CLANDRO_PKG_TMPDIR}/bin/generate_argument_manpage" -fno-sanitize=all \
		-I"${CLANDRO_PKG_BUILDDIR}/include" -I"${CLANDRO_PKG_BUILDDIR}/winpr/include" -I"${CLANDRO_PKG_SRCDIR}/winpr/include"
	PATH+=":${CLANDRO_PKG_TMPDIR}/bin"
}
