CLANDRO_PKG_HOMEPAGE=https://mpv.io/
CLANDRO_PKG_DESCRIPTION="Command-line media player"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev>"
# Update both mpv and mpv-x to the same version in one PR.
CLANDRO_PKG_VERSION="0.41.0"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/mpv-player/mpv/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ee21092a5ee427353392360929dc64645c54479aefdb5babc5cfbb5fad626209
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="alsa-lib, ffmpeg, jack, libandroid-glob, libandroid-shmem, libarchive, libass, libbluray, libcaca, libdrm, libdvdnav, libiconv, libjpeg-turbo, libplacebo, libsixel, libuchardet, libx11, libxext, libxinerama, libxpresent, libxrandr, libxss, libzimg, littlecms, luajit, openal-soft, opengl, pipewire, pulseaudio, rubberband, vulkan-icd, zlib"
CLANDRO_PKG_BUILD_DEPENDS="vulkan-headers, vulkan-loader-generic"
CLANDRO_PKG_CONFLICTS="mpv"
CLANDRO_PKG_REPLACES="mpv"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dlibmpv=true
-Dlua=luajit
-Ddvdnav=enabled
-Dvapoursynth=disabled
-Dopenal=enabled
-Dgbm=disabled
-Dgl-x11=enabled
-Dvdpau=disabled
-Dvaapi=disabled
-Dvulkan=enabled
-Dxv=disabled
-Dandroid-media-ndk=disabled
"

# shellcheck disable=SC2031
clandro_step_post_get_source() {
	# Version guard
	local ver_m ver_x
	ver_m="$(. "$CLANDRO_SCRIPTDIR/packages/mpv/build.sh"; echo "${CLANDRO_PKG_VERSION#*:}")"
	ver_x="${CLANDRO_PKG_VERSION#*:}"
	if [[ "${ver_m}" != "${ver_x}" ]]; then
		clandro_error_exit "Version mismatch between mpv and mpv-x."
	fi
}

# shellcheck disable=SC2031
clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-glob -landroid-shmem"
	sed -i "s/host_machine.system() == 'android'/false/" "${CLANDRO_PKG_SRCDIR}/meson.build"
}

clandro_step_post_make_install() {
	# Use opensles audio out by default:
	install -Dm600 -t "$CLANDRO_PREFIX/etc/mpv/" "$CLANDRO_PKG_BUILDER_DIR/mpv.conf"
	install -Dm600 -t "$CLANDRO_PREFIX/share/mpv/scripts/" "$CLANDRO_PKG_SRCDIR/TOOLS/lua"/*
}
