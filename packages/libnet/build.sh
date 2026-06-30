CLANDRO_PKG_HOMEPAGE=https://github.com/libnet/libnet
CLANDRO_PKG_DESCRIPTION="A library which provides API for commonly used low-level net functions"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/libnet/libnet/releases/download/v$CLANDRO_PKG_VERSION/libnet-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=ad1e2dd9b500c58ee462acd839d0a0ea9a2b9248a1287840bc601e774fb6b28f
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=9

	local e=$(sed -En 's/^libnet_la_LDFLAGS\s*=.*\s+-version-info\s+([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			src/Makefile.am)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
