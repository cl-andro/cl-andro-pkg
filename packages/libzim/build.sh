CLANDRO_PKG_HOMEPAGE=https://openzim.org
CLANDRO_PKG_DESCRIPTION="The ZIM library is the reference implementation for the ZIM file format."
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="9.6.0"
CLANDRO_PKG_SRCURL="https://github.com/openzim/libzim/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=a4211000de19df0a36dd48180b295be63adfbdaba3ef75545b32087c0bd8189d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libicu, liblzma, libxapian, zstd"
CLANDRO_PKG_BUILD_DEPENDS="googletest, libuuid"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=9

	local v=$(echo ${CLANDRO_PKG_VERSION#*:} | cut -d . -f 1)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
