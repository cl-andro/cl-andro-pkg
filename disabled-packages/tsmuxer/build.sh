CLANDRO_PKG_HOMEPAGE=https://github.com/justdan96/tsMuxer
CLANDRO_PKG_DESCRIPTION="A transport stream muxer for remuxing/muxing elementary streams"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# Update both tsmuxer and tsmuxergui to the same version in one PR.
_VERSION_REAL=nightly-2023-01-30-02-16-12
CLANDRO_PKG_VERSION=$(cut -d- -f2,3,4 <<< "$_VERSION_REAL" | tr '-' '.')
CLANDRO_PKG_SRCURL=https://github.com/justdan96/tsMuxer/archive/refs/tags/${_VERSION_REAL}.tar.gz
CLANDRO_PKG_SHA256=e975d7ab9a73448b1c2c1ded311977a6f0dc77398edb720158dbcf213d9cf4df
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="freetype, libc++, zlib"

clandro_step_post_get_source() {
	# Version guard
	local ver_t=${CLANDRO_PKG_VERSION#*:}
	local ver_g=$(. $CLANDRO_SCRIPTDIR/x11-packages/tsmuxergui/build.sh; echo ${CLANDRO_PKG_VERSION#*:})
	if [ "${ver_t}" != "${ver_g}" ]; then
		clandro_error_exit "Version mismatch between tsmuxer and tsmuxergui."
	fi
}
