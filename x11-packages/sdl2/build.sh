CLANDRO_PKG_HOMEPAGE=https://www.libsdl.org
CLANDRO_PKG_DESCRIPTION="A library for portable low-level access to a video framebuffer, audio output, mouse, and keyboard (version 2)"
CLANDRO_PKG_LICENSE="ZLIB"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.32.10"
CLANDRO_PKG_SRCURL=https://www.libsdl.org/release/SDL2-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=5f5993c530f084535c65a6879e9b26ad441169b3e25d789d83287040a9ca5165
CLANDRO_PKG_DEPENDS="libdecor, libiconv, libwayland, libx11, libxcursor, libxext, libxfixes, libxi, libxkbcommon, libxrandr, libxss, pulseaudio"
CLANDRO_PKG_BUILD_DEPENDS="libwayland-cross-scanner, libwayland-protocols, opengl"
CLANDRO_PKG_RECOMMENDS="opengl"
CLANDRO_PKG_CONFLICTS="libsdl2"
CLANDRO_PKG_REPLACES="libsdl2"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-3dnow
--disable-alsa
--disable-assembly
--disable-dbus
--disable-directx
--disable-esd
--disable-fcitx
--disable-ibus
--disable-ime
--disable-libudev
--disable-mmx
--disable-oss
--disable-pthread-sem
--disable-render-d3d
--disable-render-metal
--disable-video-cocoa
--disable-video-kmsdrm
--disable-video-rpi
--disable-video-vivante
--enable-libdecor
--enable-pthreads
--enable-video-opengl
--enable-video-opengles
--enable-video-opengles1
--enable-video-opengles2
--enable-video-vulkan
--enable-video-wayland
--enable-video-x11-scrnsaver
--enable-video-x11-xcursor
--enable-video-x11-xdbe
--enable-video-x11-xfixes
--enable-video-x11-xinput
--enable-video-x11-xrandr
--enable-video-x11-xshape
--x-includes=${CLANDRO_PREFIX}/include
--x-libraries=${CLANDRO_PREFIX}/lib
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local v=$(sed -En 's/^LT_MAJOR=([0-9]+).*/\1/p' configure.ac)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	rm -rf "$CLANDRO_PKG_SRCDIR"/Xcode-iOS
	find "$CLANDRO_PKG_SRCDIR" -type f | \
		xargs -n 1 sed -i \
		-e 's/\([^A-Za-z0-9_]__ANDROID\)\(__[^A-Za-z0-9_]\)/\1_NO_TERMUX\2/g' \
		-e 's/\([^A-Za-z0-9_]__ANDROID\)__$/\1_NO_TERMUX__/g'

	clandro_setup_wayland_cross_pkg_config_wrapper
}

clandro_step_post_make_install() {
	# ld(1)ing with `-lSDL2` won't work without this:
	# https://github.com/termux/x11-packages/issues/633
	ln -sf libSDL2-2.0.so ${CLANDRO_PREFIX}/lib/libSDL2.so
}
