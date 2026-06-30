CLANDRO_PKG_HOMEPAGE="https://github.com/Unrud/video-downloader"
CLANDRO_PKG_DESCRIPTION="Download videos from websites like YouTube and many others (based on yt-dlp)"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.12.31"
CLANDRO_PKG_SRCURL="https://github.com/Unrud/video-downloader/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256="9cdfdb1cb84455d9d231890aefb29ad82441fe27d6e8b6419412e7d5ee1189b3"
CLANDRO_PKG_DEPENDS="ffmpeg, libadwaita, librsvg, pygobject, python, python-yt-dlp"
CLANDRO_PKG_BUILD_DEPENDS="glib-cross"
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		clandro_download_ubuntu_packages librsvg2-bin librsvg2-2
	fi
}

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
	clandro_setup_meson

	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		local _WRAPPER_BIN="${CLANDRO_PKG_BUILDDIR}/_wrapper_bin"
		mkdir -p "${_WRAPPER_BIN}"
		cat <<-EOF >"${_WRAPPER_BIN}/rsvg-convert"
			#!/bin/sh
			export LD_LIBRARY_PATH="${CLANDRO_PKG_HOSTBUILD_DIR}/ubuntu_packages/usr/lib/x86_64-linux-gnu"
			exec "${CLANDRO_PKG_HOSTBUILD_DIR}/ubuntu_packages/usr/bin/rsvg-convert" "\$@"
		EOF
		chmod +x "${_WRAPPER_BIN}/rsvg-convert"
		export PATH="${_WRAPPER_BIN}:${PATH}"
	fi
}
