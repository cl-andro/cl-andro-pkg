CLANDRO_PKG_HOMEPAGE=https://github.com/justdan96/tsMuxer
CLANDRO_PKG_DESCRIPTION="A transport stream muxer for remuxing/muxing elementary streams"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# Update both tsmuxer and tsmuxergui to the same version in one PR.
_VERSION_REAL=nightly-2023-01-30-02-16-12
CLANDRO_PKG_VERSION=$(cut -d- -f2,3,4 <<< "$_VERSION_REAL" | tr '-' '.')
CLANDRO_PKG_SRCURL=https://github.com/justdan96/tsMuxer/archive/refs/tags/${_VERSION_REAL}.tar.gz
CLANDRO_PKG_SHA256=e975d7ab9a73448b1c2c1ded311977a6f0dc77398edb720158dbcf213d9cf4df
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_METHOD=repology
CLANDRO_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtmultimedia"
CLANDRO_PKG_BUILD_DEPENDS="freetype, qt5-qtbase-cross-tools, qt5-qttools-cross-tools, zlib"
CLANDRO_PKG_RM_AFTER_INSTALL="bin/tsmuxer"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_INSTALL_DATADIR=share -DTSMUXER_GUI=ON"

clandro_step_post_get_source() {
	# Version guard
	local ver_t=$(. $CLANDRO_SCRIPTDIR/packages/tsmuxer/build.sh; echo ${CLANDRO_PKG_VERSION#*:})
	local ver_g=${CLANDRO_PKG_VERSION#*:}
	if [ "${ver_t}" != "${ver_g}" ]; then
		clandro_error_exit "Version mismatch between tsmuxer and tsmuxergui."
	fi
}

clandro_step_post_make_install() {
	mv ${CLANDRO_PREFIX}/bin/tsMuxerGUI ${CLANDRO_PREFIX}/bin/tsmuxergui
}
