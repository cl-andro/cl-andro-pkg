CLANDRO_PKG_HOMEPAGE=https://libimobiledevice.org
CLANDRO_PKG_DESCRIPTION="A client library for applications to handle usbmux protocol connections with iOS devices"
CLANDRO_PKG_LICENSE="LGPL-2.1, GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.1.1"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/libimobiledevice/libusbmuxd/releases/download/${CLANDRO_PKG_VERSION}/libusbmuxd-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=5546f1aba1c3d1812c2b47d976312d00547d1044b84b6a461323c621f396efce
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libimobiledevice-glue, libplist, usbmuxd"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--without-preflight
--without-systemd
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=7

	local e=$(sed -En 's/LIBUSBMUXD_SO_VERSION="?([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
				configure.ac)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	autoreconf -fi
}

clandro_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/libusbmuxd-2.0.so"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			clandro_error_exit "SOVERSION guard check failed."
		fi
	done
}
