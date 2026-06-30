CLANDRO_PKG_HOMEPAGE=https://www.dyne.org/software/frei0r/
CLANDRO_PKG_DESCRIPTION="Minimalistic plugin API for video effects"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.1.3"
CLANDRO_PKG_SRCURL=https://github.com/dyne/frei0r/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=dcf290cdfbe583d007c300aa7733c9350ed957a0e30ca897a5c098875b8aa5dc
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libcairo"
CLANDRO_PKG_FORCE_CMAKE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_LIBDIR=$CLANDRO__PREFIX__LIB_SUBDIR
-DWITHOUT_GAVL=ON
-DWITHOUT_OPENCV=ON
"

clandro_pkg_auto_update() {
	local latest_tag="$(clandro_github_api_get_tag "${CLANDRO_PKG_SRCURL}")"
	[[ -z "${latest_tag}" ]] && clandro_error_exit "Unable to get tag from ${CLANDRO_PKG_SRCURL}"
	clandro_pkg_upgrade_version "${latest_tag#v}"
}
