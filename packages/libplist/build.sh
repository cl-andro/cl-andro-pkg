CLANDRO_PKG_HOMEPAGE=https://libimobiledevice.org
CLANDRO_PKG_DESCRIPTION="A small portable C library to handle Apple Property List files in binary or XML format"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.1"
CLANDRO_PKG_LICENSE_FILE="COPYING, COPYING.LESSER"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.7.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/libimobiledevice/libplist/releases/download/${CLANDRO_PKG_VERSION}/libplist-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=7ac42301e896b1ebe3c654634780c82baa7cb70df8554e683ff89f7c2643eb8b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--without-cython
"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=4

	local e=$(sed -En 's/^LIBPLIST_SO_VERSION="?([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
				configure.ac)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}

clandro_step_pre_configure() {
	sed -e 's|#if _MSC_VER|#if defined(_MSC_VER)|' -i include/plist/plist.h
	autoreconf -fi
}
