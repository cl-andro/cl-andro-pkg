CLANDRO_PKG_HOMEPAGE=https://code.videolan.org/videolan/libdvdread
CLANDRO_PKG_DESCRIPTION="A library that allows easy use of sophisticated DVD navigation features"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="7.0.1"
CLANDRO_PKG_SRCURL=https://code.videolan.org/videolan/libdvdread/-/archive/${CLANDRO_PKG_VERSION}/libdvdread-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=5eeda23c75405c89d04f4c601cbb99447477ea5c8c05b341c59da07b1651155b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag

clandro_step_pre_configure() {
	export CLANDRO_MESON_ENABLE_SOVERSION=1
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _GUARD_FILE="lib/libdvdread.so.8"
	if [ ! -e "${_GUARD_FILE}" ]; then
		clandro_error_exit "file ${_GUARD_FILE} not found."
	fi
}
