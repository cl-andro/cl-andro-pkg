CLANDRO_PKG_HOMEPAGE=https://github.com/librsync/librsync
CLANDRO_PKG_DESCRIPTION="Remote delta-compression library"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.3.4"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/librsync/librsync/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a0dedf9fff66d8e29e7c25d23c1f42beda2089fb4eac1b36e6acd8a29edfbd1f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libbz2"
CLANDRO_PKG_BUILD_DEPENDS="libpopt"
CLANDRO_PKG_BREAKS="librsync-dev"
CLANDRO_PKG_REPLACES="librsync-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DPERL_EXECUTABLE=$(command -v perl)"

clandro_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2

	local v=$(echo ${CLANDRO_PKG_VERSION#*:} | cut -d . -f 1)
	if [ "${v}" != "${_SOVERSION}" ]; then
		clandro_error_exit "SOVERSION guard check failed."
	fi
}
