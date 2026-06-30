CLANDRO_PKG_HOMEPAGE=https://code.videolan.org/videolan/libbluray/
CLANDRO_PKG_DESCRIPTION="An open-source library designed for Blu-Ray Discs playback for media players"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.1"
CLANDRO_PKG_SRCURL=https://downloads.videolan.org/pub/videolan/libbluray/${CLANDRO_PKG_VERSION}/libbluray-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=76b5dc40097f28dca4ebb009c98ed51321b2927453f75cc72cf74acd09b9f449
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fontconfig, freetype, libudfread, libxml2"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dbdj_jar=disabled
"

clandro_step_pre_configure() {
	unset JDK_HOME
	export CLANDRO_MESON_ENABLE_SOVERSION=1
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _GUARD_FILE="lib/libbluray.so.3"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
