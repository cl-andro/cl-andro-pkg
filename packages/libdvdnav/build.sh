CLANDRO_PKG_HOMEPAGE=https://www.videolan.org/developers/libdvdnav.html
CLANDRO_PKG_DESCRIPTION="A library that allows easy use of sophisticated DVD navigation features"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="7.0.0"
CLANDRO_PKG_SRCURL=https://code.videolan.org/videolan/libdvdnav/-/archive/${CLANDRO_PKG_VERSION}/libdvdnav-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=15d28086937647a95c3d6b083f0a86678cd4dd428914e319c64adf52cadec786
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libdvdread"

clandro_step_pre_configure() {
	export CLANDRO_MESON_ENABLE_SOVERSION=1
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _GUARD_FILE="lib/libdvdnav.so.4"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
