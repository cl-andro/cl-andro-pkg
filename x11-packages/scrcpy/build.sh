CLANDRO_PKG_HOMEPAGE=https://github.com/Genymobile/scrcpy
CLANDRO_PKG_DESCRIPTION="Provides display and control of Android devices connected via USB or over TCP/IP"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.3.4"
CLANDRO_PKG_SRCURL=https://github.com/Genymobile/scrcpy/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=03b72d1f71ca7783cff2995ca7cd8c67b9b75038a3cc35e443a1913e951b49dd
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="android-tools, ffmpeg, libusb, sdl2 | sdl2-compat"
CLANDRO_PKG_ANTI_BUILD_DEPENDS="android-tools, sdl2-compat"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dprebuilt_server=$CLANDRO_PKG_SRCDIR/scrcpy-server-v${CLANDRO_PKG_VERSION}
"

clandro_step_post_get_source() {
	local _url=https://github.com/Genymobile/scrcpy/releases/download/v${CLANDRO_PKG_VERSION}/scrcpy-server-v${CLANDRO_PKG_VERSION}
	clandro_download ${_url} $(basename ${_url}) SKIP_CHECKSUM
	# We are skipping checksum checking, but we should ensure it is android package.
	[[ "$(file $(basename ${_url}))"==*"Android package"*  || "$(file $(basename ${_url}))"==*"Zip archive data"* ]] \
		|| clandro_error_exit "$(basename ${_url}) has wrong signature: $(file $(basename ${_url}))"
}
